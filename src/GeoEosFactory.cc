#include <CLHEP/Units/SystemOfUnits.h>

#include <G4Ellipsoid.hh>
#include <G4LogicalBorderSurface.hh>
#include <G4LogicalVolume.hh>
#include <G4Material.hh>
#include <G4PVPlacement.hh>
#include <G4SubtractionSolid.hh>
#include <G4Tubs.hh>
#include <G4UnionSolid.hh>
#include <G4VPhysicalVolume.hh>
#include <G4VSolid.hh>
#include <GeoEosFactory.hh>
#include <RAT/GeoTubeFactory.hh>

namespace EOS {

G4VSolid *GeoEosFactory::ConstructSolid(RAT::DBLinkPtr table) {
  // Outer radius of cylindrical part of Eos
  G4double r_max = table->GetD("r_max");
  // Half-height of cylindrical part of Eos
  G4double size_z = table->GetD("size_z");
  // Radius of spherical bottom/top cap
  G4double top_radius = table->GetD("top_radius");
  // Cutoff height for the spherical top cap, where the neck begins
  G4double top_height = table->GetD("top_height");
  // Offset for cap
  G4double offset = table->GetD("offset");
  // build legs?
  G4bool build_legs = false;
  try {
    build_legs = table->GetZ("build_legs");
  } catch (RAT::DBNotFoundError &e) {
  }
  G4double leg_height, leg_rmin, leg_phi_delta, leg_phi_start;
  G4int leg_n;
  if (build_legs) {
    leg_height = table->GetD("leg_height");
    leg_rmin = table->GetD("leg_rmin");
    // leg rmax is the same as the tank rmax
    leg_n = table->GetI("leg_n");
    leg_phi_delta = table->GetD("leg_phi_delta");
    leg_phi_start = table->GetD("leg_phi_start");
  }
  // Solids for the cylindrical body and ellipical caps
  G4Tubs *body = new G4Tubs("body", 0., r_max * CLHEP::mm, size_z * CLHEP::mm, 0., CLHEP::twopi);
  G4double cap_zcut = sqrt(top_radius * top_radius - r_max * r_max);
  // Use ellipsoid for spherical caps to allow z-plane cuts
  G4Ellipsoid *head = new G4Ellipsoid("head", top_radius * CLHEP::mm, top_radius * CLHEP::mm, top_radius * CLHEP::mm,
                                      cap_zcut * CLHEP::mm, (cap_zcut + top_height) * CLHEP::mm);

  G4Ellipsoid *bot = new G4Ellipsoid("bot", top_radius * CLHEP::mm, top_radius * CLHEP::mm, top_radius * CLHEP::mm,
                                     -top_radius * CLHEP::mm, -cap_zcut * CLHEP::mm);
  G4double vessel_corner_height = size_z - cap_zcut - offset;
  // Location and rotation of the top cap
  G4ThreeVector *trans = new G4ThreeVector(0., 0., vessel_corner_height * CLHEP::mm);
  G4RotationMatrix *zero_rotation = new G4RotationMatrix();
  G4Transform3D *transf = new G4Transform3D(*zero_rotation, *trans);

  // Add the top cap to the cylinder for both the vessel and cavity
  G4VSolid *EosVolumeBodyTop = new G4UnionSolid("eos_body_top", body, head, *transf);

  // Location of the bottom cap (same rotation as the top)
  G4ThreeVector *neg_trans = new G4ThreeVector(0., 0., -vessel_corner_height * CLHEP::mm);
  G4Transform3D *neg_transf = new G4Transform3D(*zero_rotation, *neg_trans);

  // Add the bottom cap to the (top cap + cylinder) for both the vessel and cavity
  G4UnionSolid *EosVolume = new G4UnionSolid("eos_vessel", EosVolumeBodyTop, bot, *neg_transf);

  // Add legs
  G4VSolid *EosVolumeWithLegs = EosVolume;
  if (build_legs) {
    for (int i_leg = 0; i_leg < leg_n; i_leg++) {
      auto *leg = new G4Tubs(
          "leg_" + std::to_string(i_leg), leg_rmin * CLHEP::mm, r_max * CLHEP::mm, (size_z + leg_height) * CLHEP::mm,
          leg_phi_start * CLHEP::deg + i_leg * CLHEP::twopi / leg_n * CLHEP::rad, leg_phi_delta * CLHEP::deg);
      EosVolumeWithLegs = new G4UnionSolid("eos_vessel_with_legs", EosVolumeWithLegs, leg);
    }
  }

  return EosVolumeWithLegs;
}

}  // namespace EOS
