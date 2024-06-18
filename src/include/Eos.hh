#ifndef __EOS_Eos__
#define __EOS_Eos__

#include <Config.hh>
#include <DichroiconArrayFactory.hh>
#include <DirSourceFactory.hh>
#include <GeoEosFactory.hh>
#include <HitmanProc.hh>
#include <LaserballGenerator.hh>
#include <NtupleProc.hh>
#include <RAT/AnyParse.hh>
#include <RAT/Factory.hh>
#include <RAT/GLG4Gen.hh>
#include <RAT/ProcAllocator.hh>
#include <RAT/ProcBlockManager.hh>
#include <RAT/Rat.hh>
#include <string>

namespace EOS {

class Eos : public RAT::Rat {
 public:
  Eos(RAT::AnyParse* parser, int argc, char** argv);
};

}  // namespace EOS

#endif
