#include <Eos.hh>

namespace EOS {
Eos::Eos(RAT::AnyParse* parser, int argc, char** argv) : Rat(parser, argc, argv) {
  // Append an additional data directory (for ratdb and geo)
  char* eosdata = getenv("EOSDATA");
  if (eosdata != NULL) {
    ratdb_directories.insert(static_cast<std::string>(eosdata) + "/ratdb");
    model_directories.insert(static_cast<std::string>(eosdata) + "/models");
  }
  // H5 Producer
  prodBlock.AppendProducer<InHDF5Producer>();
  try {
    if (this->input_filename != "") {
      rdb->Set("IO", "HDF5Proc", "default_input_filename", this->input_filename);
      RAT::info << "Setting default input filename to " << this->input_filename << newline;
    }
  } catch (RAT::DBNotFoundError& e) {
    RAT::Log::Die("DB: Field " + e.table + "[" + e.index + "]." + e.field +
                  " lookup failure. Does not exist or has wrong type.");
  }
  // Initialize a geometry factory
  new GeoEosFactory();
  new DichroiconArrayFactory();
  new DirSourceFactory();

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
