#ifndef __RAT_GeoEosFactory__
#define __RAT_GeoEosFactory__

#include <RAT/GeoSolidFactory.hh>

namespace EOS {
class GeoEosFactory : public RAT::GeoSolidFactory {
 public:
  GeoEosFactory() : GeoSolidFactory("eos"){};
  virtual G4VSolid *ConstructSolid(RAT::DBLinkPtr table);
};

}  // namespace EOS

#endif
