#ifndef __RAT_LaserballGenerator__
#define __RAT_LaserballGenerator__

#include <G4Color.hh>
#include <G4LogicalVolume.hh>
#include <RAT/DB.hh>
#include <RAT/Gen_LED.hh>
#include <RAT/GeoFactory.hh>
#include <vector>

namespace EOS {

class LaserballGenerator : public RAT::Gen_LED {
 public:
  LaserballGenerator();
  virtual ~LaserballGenerator();
  void virtual SetState(G4String);
  void virtual CreateGeometry();
  void virtual SetVis(G4LogicalVolume*, std::vector<double>);
  G4VisAttributes* GetColor(std::vector<double>);

 private:
  RAT::DBLinkPtr laserballDB;
};

}  // namespace EOS

#endif
