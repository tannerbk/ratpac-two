#include <HitmanProc.hh>

#if TENSORFLOW_Enabled
#include <cppflow/cppflow.h>
#include <cppflow/model.h>
#include <filesystem>
#include <RAT/DB.hh>
#include <RAT/DS/EV.hh>
#include <RAT/DS/FitResult.hh>
#include <RAT/DS/PMTInfo.hh>
#include <RAT/DS/Root.hh>
#include <RAT/DS/RunStore.hh>
#include <RAT/Rat.hh>
#include <RAT/Processor.hh>
#include <RAT/Log.hh>
//#include <Minuit2/Minuit2Minimizer.h>

#include <RAT/DS/Run.hh>
#include <RAT/DS/PMT.hh>
#include <iostream>

namespace EOS {

    HitmanProc::HitmanProc() : RAT::Processor("hitman") {
        RAT::DB* db = RAT::DB::Get();
    }

    RAT::Processor::Result HitmanProc::Event(RAT::DS::Root* ds, RAT::DS::EV* ev) {
        RAT::DS::FitResult* fit = new RAT::DS::FitResult("hitman");

        std::cout << "\n*\n*\n*\n*\n*\n*\n*\n*\n THIS IS A TEST FOR IMPORTING HITS \n*\n*\n*\n*\n*\n*\n*\n*\n" << std::endl;

        RAT::DS::MC* mc = ds->GetMC();

        int totalhits = 0;
        std::vector<float> hitsData; // Temporary vector to accumulate hits data

        for (int ipmt = 0; ipmt < mc->GetMCPMTCount(); ipmt++) {
          RAT::DS::MCPMT* mcpmt = mc->GetMCPMT(ipmt);
          int npe = mcpmt->GetMCPhotonCount();

          for (int iPE = 0; iPE < npe; iPE++) {
            double time = mcpmt->GetMCPhoton(iPE)->GetFrontEndTime();
            int pmtID = mcpmt->GetID();

            hitsData.push_back(static_cast<float>(x_pos_pmt[pmtID]));
            hitsData.push_back(static_cast<float>(y_pos_pmt[pmtID]));
            hitsData.push_back(static_cast<float>(z_pos_pmt[pmtID]));
            hitsData.push_back(static_cast<float>(time));
            hitsData.push_back(static_cast<float>(1.0)); // Placeholder for charge in a single p.e. pulse (may be removed)

            totalhits++;
          }
        }

        int numCols = 5; // Number of columns

        // Create the 'hits' tensor with the correct shape
        cppflow::tensor hits(hitsData, { totalhits, numCols });
        cppflow::tensor charge({ static_cast<float>(totalhits), static_cast<float>(totalhits) });

        std::cout << "hits:" << std::endl;
        std::cout << cppflow::to_string(hits) << std::endl;

        std::cout << "charge:" << std::endl;
        std::cout << cppflow::to_string(charge) << std::endl;

        // Set the seed
        float x_seed = 0.0;
        float y_seed = 0.0;
        float z_seed = 0.0;
        float ze_seed = 0.7;
        float az_seed = 3.14;
        float t_seed = 0.0;
        float E_seed = 1.7;

        std::vector<float> hyp_data(totalhits * 7, 0.0);

        for (int ahit = 0; ahit < totalhits; ahit++) {
          int index = ahit * 7;

          hyp_data[index] = x_seed;
          hyp_data[index + 1] = y_seed;
          hyp_data[index + 2] = z_seed;
          hyp_data[index + 3] = ze_seed;
          hyp_data[index + 4] = az_seed;
          hyp_data[index + 5] = t_seed;
          hyp_data[index + 6] = E_seed;
        }

        cppflow::tensor hyp(hyp_data, { totalhits, 7 });

        std::cout << "hypothesis:" << std::endl;
        std::cout << cppflow::to_string(hyp) << std::endl;

        //
        // Testing network evaluation with dummy data
        //
        auto input_1 = cppflow::fill({10, 5}, 1.0f);
        auto input_2 = cppflow::fill({10, 7}, -1.0f);
        auto output = (*this->hitnet)(
          {
            { "serving_default_input_1:0", input_1 },
            { "serving_default_input_2:0", input_2}
          },
          { "StatefulPartitionedCall:0" }
        );

        std::cout << "Hitnet output:" << std::endl;
        std::cout << output << std::endl;
        //
        // end of test
        //

        TVector3 fitPosition(0.0, 0.0, 0.0);
        TVector3 fitDirection(1.0, 0.0, 0.0);
        double fitEnergy = 1.0;
        double fitTime = 0.0;

        fit->SetPosition(fitPosition);
        fit->SetDirection(fitDirection);
        fit->SetEnergy(fitEnergy);
        fit->SetTime(fitTime);

        ev->AddFitResult(fit);

        return RAT::Processor::OK;
    }

    void HitmanProc::BeginOfRun(RAT::DS::Run* run) {
        RAT::DB* db = RAT::DB::Get();
        // Hitman variables stored in ratdb
        RAT::DBLinkPtr table = db->GetLink("Fitter","HITMAN");
        std::string directory = table->GetS("directory");
        std::cout<<directory<<std::endl;

        //load HITMAN models
        cppflow::model* hitnet = new cppflow::model(directory + "/hitnet/");
        cppflow::model* chargenet = new cppflow::model(directory + "/chargenet/");
        //std::<<cout<<"Model found at directory: "<<directory<<std::endl;

        //get map from PMT ID to PMT positions
        run_pmtinfo = run->GetPMTInfo();
        int npmt = run_pmtinfo->GetPMTCount();

        for (int apmt = 0; apmt < npmt; apmt++) {
          TVector3 pos = run_pmtinfo->GetPosition(apmt);
          x_pos_pmt.push_back(pos.X());
          y_pos_pmt.push_back(pos.Y());
          z_pos_pmt.push_back(pos.Z());

        }
    }

} // namespace EOS
#endif