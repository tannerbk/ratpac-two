#include <RAT/Rat.hh>
#include <RAT/AnyParse.hh>
#include <RAT/ProcBlockManager.hh>
#include <RAT/ProcAllocator.hh>
#include <GeoEosFactory.hh>
#include <HitmanProc.hh>
#include <Config.hh>
#include <string>
#include <iostream>
#include <stdlib.h>

namespace EOS {
class Eos : public RAT::Rat {
public:
  Eos(RAT::AnyParse* p, int argc, char** argv) 
    : Rat(p, argc, argv)
  {
    // Append an additional data directory (for ratdb and geo)
    char* eosdata = getenv("EOSDATA");
    if( eosdata != NULL ){
      ratdb_directories.insert(static_cast<std::string>(eosdata)+"/ratdb");
      model_directories.insert(static_cast<std::string>(eosdata)+"/models");
    }
    // Initialize a geometry factory
    new GeoEosFactory();
#if TENSORFLOW_Enabled
    RAT::ProcBlockManager::AppendProcessor<HitmanProc>();
#endif
    // Include a new type of processor
    // Add a unique component to the datastructure
  }
};
}

int main(int argc, char** argv) {
  auto parser = new RAT::AnyParse(argc, argv);
  std::cout << "Eos version: " << RAT::EOSVERSION << std::endl;
  auto eos = EOS::Eos( parser, argc, argv );
  eos.Begin();
  eos.Report();
}
