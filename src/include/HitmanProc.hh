#ifndef __EOS_HitmanProc__
#define __EOS_HitmanProc__

#include <Config.hh>
#if TENSORFLOW_Enabled
#include <cppflow/cppflow.h>

#include <RAT/Processor.hh>
#include <RAT/DS/Root.hh>
#include <RAT/DS/EV.hh>
#include <string>

namespace EOS {

class HitmanProc : public RAT::Processor {
 public:
  HitmanProc();
  virtual ~HitmanProc() {}

  virtual RAT::Processor::Result Event(RAT::DS::Root *ds, RAT::DS::EV *ev);

 protected:
  cppflow::model *hitmanModel;
};

}

#endif
#endif
