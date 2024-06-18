// +---------------------------------+
// | Directional Beta Source Factory |
// +---------------------------------+
//  * Created: 04-24-2024
//  * Last Modified: 05-08-2024

#ifndef __RAT_DirSourceFactory__
#define __RAT_DirSourceFactory__

#include <G4VPhysicalVolume.hh>
#include <RAT/GeoFactory.hh>

namespace EOS {
class DirSourceFactory : public RAT::GeoFactory {
 public:
  DirSourceFactory() : GeoFactory("DirSource") {};
  virtual G4VPhysicalVolume *Construct(RAT::DBLinkPtr table);
};

}  // namespace EOS

#endif
