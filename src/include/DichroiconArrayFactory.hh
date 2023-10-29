/**********************************************************************
 * Filename:   DichroiconArrayFactory
 * Author:     James Shen <jierans@sas.upenn.edu>
 * Date:       8/8/23 1:51 PM
 **********************************************************************/
#ifndef __EOS_DichroiconArrayFactory__
#define __EOS_DichroiconArrayFactory__

#include <G4VisAttributes.hh>
#include <RAT/GeoFactory.hh>

namespace EOS {
class DichroiconArrayFactory : public RAT::GeoFactory {
 public:
  DichroiconArrayFactory() : RAT::GeoFactory("DichroiconArray"){};

  void ConstructDichroicons(RAT::DBLinkPtr table, const std::vector<G4ThreeVector> &pos,
                            const std::vector<G4ThreeVector> &dir);

  G4VPhysicalVolume *Construct(RAT::DBLinkPtr table) override;

 protected:
  static G4VisAttributes *GetColor(const std::vector<double> &color);
  static void SetVis(G4LogicalVolume *volume, const std::vector<double> &color);
};

}  // namespace EOS

#endif __EOS_DichroiconArrayFactory__
