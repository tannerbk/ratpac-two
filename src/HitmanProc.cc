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

namespace EOS {

HitmanProc::HitmanProc() : RAT::Processor("hitman") {
  RAT::DB *db = RAT::DB::Get();
  // Hitman variables stored in ratdb
  /*
  RAT::DBLinkPtr table = db->GetLink("Fitter", "Hitman");
  std::string directory = table->GetS("directory");
  std::string path = "";
  for(auto dir : Rat::model_directories) {
    std::string fullpath = dir + directory;
    if(std::filesystem::exists(fullpath)){
      path = fullpath;
      break;
    }
  }
  if(!std::filesystem::exists(path)){
    RAT::Log::Die("Could not find Hitman model at " + path);
  }

  hitmanModel = new cppflow::model(path);
  */
}

RAT::Processor::Result HitmanProc::Event(RAT::DS::Root *ds, RAT::DS::EV *ev) {
  RAT::DS::FitResult *fit = new RAT::DS::FitResult("Hitman");

  // Perform the fit
  
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

}
#endif
