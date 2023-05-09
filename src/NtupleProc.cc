#include <NtupleProc.hh>
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

NtupleProc::NtupleProc() : RAT::OutNtupleProc() {
  // The registered this->name is used by the macro when calling
  // /rat/proc tantuple
  this->name = "tantuple";
}

NtupleProc::~NtupleProc() {
  this->FillMeta();
}

void NtupleProc::AssignAdditionalAddresses() {
  this->outputTree->Branch("tannerNumber", &tannerNumber);
}

void NtupleProc::AssignAdditionalMetaAddresses() {
  this->metaTree->Branch("tannerMessage", &tannerMessage);
}

void NtupleProc::FillEvent(RAT::DS::Root* ds, RAT::DS::EV* ev){
  // Sub-event by sub-event logic
  this->tannerNumber = 1.234;
}

void NtupleProc::FillNoTriggerEvent(RAT::DS::Root* ds){
  // For events that contain no sub-event
  this->tannerNumber = 0.0;
}

void NtupleProc::FillMeta(){
  this->tannerMessage = 9.11;
}

}
