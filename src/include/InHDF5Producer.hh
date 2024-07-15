#ifndef __RAT_InHDF5Producer__
#define __RAT_InHDF5Producer__

#include <RAT/ProcBlock.hh>
#include <RAT/Producer.hh>
#include <globals.hh>
#include <string>

class G4UIcmdWithAString;
class G4UIcommand;

namespace EOS {

class InHDF5Producer : public RAT::Producer {
 public:
  InHDF5Producer();
  InHDF5Producer(RAT::ProcBlock *block);
  virtual ~InHDF5Producer();

  virtual bool ReadEvents(G4String filename);

  // override G4UImessenger (from Producer) methods
  virtual G4String GetCurrentValue(G4UIcommand *command);
  virtual void SetNewValue(G4UIcommand *command, G4String newValue);

 protected:
  void Init();

  G4UIcmdWithAString *readCmd;
  G4UIcommand *readDefaultCmd;
};

}  // namespace EOS

#endif
