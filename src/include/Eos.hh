#ifndef __EOS_Eos__
#define __EOS_Eos__

#include <Config.hh>
#include <RAT/Rat.hh>
#include <RAT/AnyParse.hh>
#include <RAT/ProcBlockManager.hh>
#include <RAT/ProcAllocator.hh>
#include <GeoEosFactory.hh>
#include <DichroiconArrayFactory.hh>
#include <HitmanProc.hh>
#include <NtupleProc.hh>
#include <string>

namespace EOS {

class Eos : public RAT::Rat {
public:
  Eos(RAT::AnyParse* parser, int argc, char** argv);
};

}

#endif
