#include <RAT/Rat.hh>
#include <RAT/AnyParse.hh>
#include <GeoEosFactory.hh>
#include <string>
#include <iostream>
#include <stdlib.h>

class Eos : public RAT::Rat {
public:
  Eos(RAT::AnyParse* p, int argc, char** argv) 
    : Rat(p, argc, argv)
  {
    // Append an additional data directory (for ratdb and geo)
    char* eosdata = getenv("EOSDATA");
    if( eosdata != NULL ){
      directories.insert(static_cast<std::string>(eosdata));
    }
    // Initialize a geometry factory
    new RAT::GeoEosFactory();
    // Include a new type of processor
    // Add a unique component to the datastructure
  }
};

int main(int argc, char** argv) {
  auto parser = new RAT::AnyParse(argc, argv);
  auto eos = Eos( parser, argc, argv );
  eos.Begin();
  eos.Report();
}
