#include <Eos.hh>

namespace EOS {
Eos::Eos(RAT::AnyParse* parser, int argc, char** argv) : Rat(parser, argc, argv) {
  // Append an additional data directory (for ratdb and geo)
  char* eosdata = getenv("EOSDATA");
  if (eosdata != NULL) {
    ratdb_directories.insert(static_cast<std::string>(eosdata) + "/ratdb");
    model_directories.insert(static_cast<std::string>(eosdata) + "/models");
  }
  // Initialize a geometry factory
  new GeoEosFactory();
  new DichroiconArrayFactory();
#if TENSORFLOW_Enabled && NLOPT_Enabled
  RAT::ProcBlockManager::AppendProcessor<HitmanProc>();
#endif
  RAT::ProcBlockManager::AppendProcessor<NtupleProc>();
  // Include a new type of processor
  // Add a unique component to the datastructure
  // Register generators
  RAT::GlobalFactory<GLG4Gen>::Register("laserball", new RAT::Alloc<GLG4Gen, LaserballGenerator>);
}
}  // namespace EOS
