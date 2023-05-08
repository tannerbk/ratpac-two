#ifndef __EOS_NtupleProc__
#define __EOS_NtupleProc__

#include <Config.hh>

#include <RAT/Processor.hh>
#include <RAT/DS/Root.hh>
#include <RAT/DS/EV.hh>
#include <string>

#include <RAT/OutNtupleProc.hh>

namespace EOS {

class NtupleProc : public RAT::OutNtupleProc {
  public:
    NtupleProc();
    ~NtupleProc();
    void AssignAdditionalAddresses() override;
    void AssignAdditionalMetaAddresses() override;
    void FillEvent(RAT::DS::Root*, RAT::DS::EV*) override;
    void FillNoTriggerEvent(RAT::DS::Root*) override;
    void FillMeta() override;
  protected:
    double tannerNumber;
    double tannerMessage;
};

}
#endif
