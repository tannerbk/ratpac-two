#include <H5Cpp.h>
#include <TTimeStamp.h>

#include <G4UIcmdWithAString.hh>
#include <G4UIdirectory.hh>
#include <InHDF5Producer.hh>
#include <RAT/Config.hh>
#include <RAT/DB.hh>
#include <RAT/DS/EV.hh>
#include <RAT/DS/Root.hh>
#include <RAT/DS/Run.hh>
#include <RAT/DS/RunStore.hh>
#include <RAT/Digitizer.hh>
#include <RAT/Log.hh>
#include <RAT/PMTFactoryBase.hh>
#include <RAT/WaveformAnalysis.hh>
#include <highfive/highfive.hpp>

namespace EOS {

InHDF5Producer::InHDF5Producer() {
  Init();
  mainBlock = nullptr;
}

InHDF5Producer::InHDF5Producer(RAT::ProcBlock *block) {
  SetMainBlock(block);
  Init();
}

InHDF5Producer::~InHDF5Producer() = default;

void InHDF5Producer::Init() {
  // Build commands
  auto *DebugDir = new G4UIdirectory("/rat/inhdf5/");
  DebugDir->SetGuidance("Read Events from Eos HDF5 file");

  readCmd = new G4UIcmdWithAString("/rat/inhdf5/read", this);
  readCmd->SetGuidance("name of input file");
  readCmd->SetParameterName("filename", false);  // required

  readDefaultCmd = new G4UIcommand("/rat/inhdf5/read_default", this);
  readDefaultCmd->SetGuidance("read from IO.default_input_filename");
}

G4String InHDF5Producer::GetCurrentValue(G4UIcommand * /*command*/) {
  RAT::Log::Die("invalid inhdf5 \"get\" command");
  return G4String("You never see this.");
}

void InHDF5Producer::SetNewValue(G4UIcommand *command, G4String newValue) {
  // readCmd
  if (command == readCmd || command == readDefaultCmd) {
    std::string filename;

    if (command == readDefaultCmd) {
      // pull from the default input filename since it will be set by rat -i
      RAT::DBLinkPtr lIO = RAT::DB::Get()->GetLink("IO", "");
      filename = lIO->GetS("default_input_filename");
    } else {
      size_t size = newValue.size();

      // Trim extraneous quotation marks to avoid confusing people
      if (size >= 2 && newValue[(size_t)0] == '\"' && newValue[size - 1] == '\"')
        filename = newValue.substr(1, size - 2);
      else
        filename = newValue;
    }

    if (!mainBlock)
      RAT::Log::Die("inhdf5: No main block declared! (should never happen)");
    else if (!ReadEvents(filename))
      RAT::Log::Die("inhdf5: Error reading from " + filename);

  } else
    RAT::Log::Die("invalid inhdf5 \"set\" command");
}

bool InHDF5Producer::ReadEvents(G4String filename) {
  RAT::info << "Reading events from " << filename << newline;
  try {
    HighFive::File h5file(filename, HighFive::File::ReadOnly);
    RAT::DBLinkPtr lIO = RAT::DB::Get()->GetLink("IO", "HDF5Proc");
    std::vector<std::string> board_sn = lIO->GetSArray("board_sn");
    std::vector<int> board_id = lIO->GetIArray("board_id");
    int first_board_id = *std::min_element(board_id.begin(), board_id.end());
    std::map<int, std::string> board_sn_map;
    for (int i = 0; i < board_sn.size(); i++) {
      board_sn_map[board_id[i]] = board_sn[i];
    }
    int channels_per_board = lIO->GetI("channels_per_board");
    float trigger_ns_per_tick = lIO->GetD("trigger_ns_per_tick");
    std::vector<int> digitized_trigger_lcn = lIO->GetIArray("digitized_trigger_lcn");
    // create dataset names, indexed by LCN
    std::map<int, std::string> dataset_names;

    for (auto const &[bid, bsn] : board_sn_map) {
      for (int ch_id = 0; ch_id < channels_per_board; ch_id++) {
        int lcn = bid * channels_per_board + ch_id;
        dataset_names[lcn] = bsn + "/ch" + std::to_string(ch_id) + "/samples";
      }
    }
    HighFive::DataSet first_channel_ds = h5file.getDataSet(dataset_names.begin()->second);
    std::vector<size_t> dset_dim = first_channel_ds.getSpace().getDimensions();
    RAT::Log::Assert(dset_dim.size() == 2, "Dataset is not 2D");
    size_t n_events = dset_dim[0];
    size_t n_samples = dset_dim[1];
    RAT::info << "Found " << dataset_names.size() << " channels, " << n_events << " events" << newline;

    // set up digitizer
    std::string digitizer_type = lIO->GetS("digitizer");
    RAT::Digitizer digitizer(digitizer_type);
    // dynamically adjust the readout window
    if (digitizer.fNSamples != n_samples)
      RAT::warn << "Digitizer readout window length is different from the HDF5 file. Using window length of "
                << n_samples << " samples as specified in the input file." << newline;
    digitizer.fNSamples = n_samples;
    RAT::WaveformAnalysis waveform_analyzer(lIO->GetS("waveform_analyzer"));

    // FIXME: Each board reports their own individual trigger time. Figure out what to with this.
    // For now, use the first board's trigger time
    HighFive::Group first_board_grp = h5file.getGroup(board_sn_map[first_board_id]);
    const auto trigger_times = first_board_grp.getDataSet("timetags").read<std::vector<uint32_t>>();
    const auto event_ids = first_board_grp.getDataSet("counters").read<std::vector<uint32_t>>();

    // run information
    int run_id = RAT::DB::Get()->GetDefaultRun();
    RAT::DS::Run *run = RAT::DS::RunStore::GetRun(run_id);
    if (!run) {
      RAT::DBLinkPtr lRun = RAT::DB::Get()->GetLink("RUN", "", run_id);
      run = new RAT::DS::Run();
      run->SetType((uint64_t)lRun->GetI("runtype"));
      // assuming run is created for the first file in the run
      TTimeStamp run_begin_utc(h5file.getAttribute("created_unix_timestamp").read<int32_t>());
      run->SetStartTime(run_begin_utc);
      run->SetID(run_id);
      const RAT::DS::PMTInfo *pmtinfo = &RAT::PMTFactoryBase::GetPMTInfo();
      run->SetPMTInfo(pmtinfo);
      RAT::DS::ChannelStatus ch_status;
      ch_status.Load(pmtinfo, lRun->GetS("channel_status"));
      run->SetChannelStatus(ch_status);
      RAT::DS::RunStore::AddNewRun(run);
    }
    const RAT::DS::PMTInfo *pmt_info = run->GetPMTInfo();
    const RAT::DS::ChannelStatus *ch_status = &run->GetChannelStatus();
    if (ch_status == NULL) {
      RAT::Log::Die("Channel status is null!");
    }
    std::map<int, int> lcn_to_pmt_id;
    for (int i = 0; i < pmt_info->GetPMTCount(); i++) {
      lcn_to_pmt_id[pmt_info->GetChannelNumber(i)] = i;
    }

    int calibrated_trigger_lcn = -1;
    try {
      calibrated_trigger_lcn = lIO->GetI("digitized_event_trigger_lcn");
      RAT::info << "Using Channel " << calibrated_trigger_lcn << "as event trigger time" << newline;
    } catch (const RAT::DBNotFoundError &e) {
    }

    // Read events
    uint64_t last_trigger_time_ns = (uint64_t)trigger_times[0] * trigger_ns_per_tick;
    for (uint32_t ievt = 0; ievt < n_events; ievt++) {
      RAT::DS::Root *dsroot = new RAT::DS::Root();
      dsroot->SetRunID(run_id);
      dsroot->SetRatVersion(RAT::RATVERSION);
      RAT::DS::EV *ev = dsroot->AddNewEV();
      ev->SetID(event_ids[ievt]);
      uint64_t trigger_time_ns = (uint64_t)trigger_times[ievt] * trigger_ns_per_tick;
      ev->SetDeltaT(trigger_time_ns - last_trigger_time_ns);
      last_trigger_time_ns = trigger_time_ns;
      // Read waveforms
      digitizer.fDigitWaveForm.clear();
      double total_charge = 0;
      // retrieve trigger time from the trigger digitization given in each board
      std::vector<double> trigger_time_per_board;
      for (auto const &[lcn, ds_name] : dataset_names) {
        if (!ch_status->GetOnlineByChannel(lcn)) {
          continue;
        }
        HighFive::DataSet ds = h5file.getDataSet(ds_name);
        std::vector<std::vector<uint16_t>> samples;
        ds.select({ievt, 0}, {1, n_samples}).read(samples);
        int pmt_id = -9999;
        try {
          pmt_id = lcn_to_pmt_id.at(lcn);
        } catch (const std::out_of_range &e) {
          pmt_id = -lcn;  // negative pmt_id means channel is not a pmt in geometry
        }

        digitizer.fDigitWaveForm[pmt_id] = samples.at(0);
        bool is_trigger = (std::count(digitized_trigger_lcn.begin(), digitized_trigger_lcn.end(), lcn) > 0);
        if (is_trigger) {
          double trigger_time = waveform_analyzer.RunAnalysisOnTrigger(pmt_id, &digitizer);
          trigger_time_per_board.push_back(trigger_time);
        } else if (pmt_id < 0) {  // don't run any analysis on waveforms not in the geometry
          continue;
        } else {
          RAT::DS::DigitPMT *digitpmt = ev->AddNewDigitPMT();
          digitpmt->SetID(pmt_id);
          waveform_analyzer.RunAnalysis(digitpmt, pmt_id, &digitizer, ch_status->GetCableOffsetByPMTID(pmt_id));
          total_charge += digitpmt->GetDigitizedTotalCharge();
        }
      }  // end loop over channels
      for (size_t i_board = 0; i_board < trigger_time_per_board.size(); i_board++) {
        double local_trigger_time = trigger_time_per_board.at(i_board);
        for (int i_channel = 0; i_channel < channels_per_board; i_channel++) {
          int lcn = board_id[i_board] * channels_per_board + i_channel;
          if (!ch_status->GetOnlineByChannel(lcn)) {
            continue;
          }
          int pmt_id = -9999;
          try {
            pmt_id = lcn_to_pmt_id.at(lcn);
          } catch (const std::out_of_range &e) {
            continue;
          }  // non-PMT channels
          bool is_trigger = (std::count(digitized_trigger_lcn.begin(), digitized_trigger_lcn.end(), lcn) > 0);
          if (is_trigger) continue;
          RAT::DS::DigitPMT *digitpmt;
          for (int digitpmt_idx = 0; digitpmt_idx < ev->GetDigitPMTCount(); digitpmt_idx++) {
            if (ev->GetDigitPMT(digitpmt_idx)->GetID() == pmt_id) {
              digitpmt = ev->GetDigitPMT(digitpmt_idx);
              break;
            }
          }
          digitpmt->SetLocalTriggerTime(local_trigger_time);
        }
      }
      if (calibrated_trigger_lcn != -1) {
        double trigger_time = waveform_analyzer.RunAnalysisOnTrigger(-calibrated_trigger_lcn, &digitizer);
        ev->SetCalibratedTriggerTime(trigger_time);
      } else {
        ev->SetCalibratedTriggerTime(0);
      }
      digitizer.DigitizeSum(ev);
      ev->SetTotalCharge(total_charge);
      mainBlock->DSEvent(dsroot);
      delete dsroot;

    }  // end loop over events

  } catch (const HighFive::Exception &e) {
    RAT::Log::Die("Error reading from " + filename + ": " + e.what());
  }
  return true;
}

}  // namespace EOS
