// +---------------------------------+
// | Directional Beta Source Factory |
// +---------------------------------+
//  * Created: 04-24-2024
//  * Last Modified: 08-30-2024

#include <CLHEP/Units/SystemOfUnits.h>

#include <DirSourceFactory.hh>
#include <G4Box.hh>
#include <G4LogicalBorderSurface.hh>
#include <G4LogicalVolume.hh>
#include <G4Material.hh>
#include <G4MultiUnion.hh>
#include <G4PVPlacement.hh>
#include <G4Polycone.hh>
#include <G4SubtractionSolid.hh>
#include <G4ThreeVector.hh>
#include <G4Tubs.hh>
#include <G4VPhysicalVolume.hh>
#include <G4VSolid.hh>
#include <RAT/DB.hh>

namespace EOS {

G4VPhysicalVolume *DirSourceFactory::Construct(RAT::DBLinkPtr table) {
  // handy stuff
  const std::string volumeName = table->GetIndex();
  G4ThreeVector zero(0.0, 0.0, 0.0);
  G4RotationMatrix rotm = G4RotationMatrix();

  // mother volume information
  const std::string motherName = table->GetS("mother");
  G4VPhysicalVolume *motherPhys = FindPhysMother(motherName);

  // shielding materials
  G4Material *outerShellMaterial = G4Material::GetMaterial(table->GetS("outer_shell_material"));
  G4Material *metalShieldMaterial = G4Material::GetMaterial(table->GetS("metal_shield_material"));
  G4Material *plasticShieldMaterial = G4Material::GetMaterial(table->GetS("plastic_shield_material"));

  // optional parameters
  // size of directional source (30mm, 20mm or 10mm)
  G4double dirSrcSize = 30.0;
  try {
    dirSrcSize = table->GetD("size");
  } catch (RAT::DBNotFoundError &e) {
  };
  if (!(dirSrcSize == 30 || dirSrcSize == 20 || dirSrcSize == 10)) {
    RAT::Log::Die("Directional Source Size should be 30mm, 20mm or 10mm");
  };
  RAT::info << "DirSourceFactory : Using Directional Source (" << dirSrcSize << "mm)." << newline;
  // material to fill empty space in source
  G4Material *fillMaterial = G4Material::GetMaterial("air");
  try {
    fillMaterial = G4Material::GetMaterial(table->GetS("fill"));
  } catch (RAT::DBNotFoundError &e) {
  };
  // thickness of the front window at end of borehole
  G4double frontZ = 0.15;  // default is 0.15 mm
  try {
    frontZ = table->GetD("front_z");
  } catch (RAT::DBNotFoundError &e) {
  };

  // position and rotation of source
  const std::vector<double> &sourceRot = table->GetDArray("rotation");
  G4RotationMatrix *rotation = new G4RotationMatrix();
  rotation->rotateZ(sourceRot[2] / 180.0 * CLHEP::pi);
  rotation->rotateY(sourceRot[1] / 180.0 * CLHEP::pi);
  rotation->rotateX(sourceRot[0] / 180.0 * CLHEP::pi);
  const std::vector<double> &sourcePos = table->GetDArray("position");
  G4ThreeVector position(sourcePos[0], sourcePos[1], sourcePos[2]);

  // source design parameters
  const G4double srcR = dirSrcSize / 2.0;  // source outer radius
  const G4double radSrcR = srcR - 2.5;     // radioactive source disk radius
  const G4double radSrcH = 3.18;           // radioactive source disk radius
  const G4double bhL = 25.0;               // borehole length
  const G4double frontR = 1.5;             // source front window radius
  const G4double bhfrontR = 0.5;           // radius of front side of borehole
  G4double activityR, fiberGatePosZ, pSfrontR1, pSfrontR2, pSfrontH, pSbackR, pSbackH;
  G4double PCBcutoutH;
  if (dirSrcSize == 30) {
    activityR = 2.5;  // radius of source activity area
    // inner plastic shield
    pSfrontR1 = 6.5;          // front shield smaller radius
    pSfrontR2 = 10.0;         // front shield larger radius
    pSfrontH = 6.0;           // front shield height
    pSbackR = 10.0;           // back shield radius
    pSbackH = 8.0 - radSrcH;  // back shield height
    // Fiber gate, SiPM and PCB cutouts
    fiberGatePosZ = 7.0;  // z position of fiber gate
    PCBcutoutH = 7.0;     // PCB cutout height
  } else if (dirSrcSize == 20) {
    activityR = 2.5;
    pSfrontR1 = 4.0;
    pSfrontR2 = 5.5;
    pSfrontH = 4.0;
    pSbackR = 5.5;
    pSbackH = 7.0 - radSrcH;
    fiberGatePosZ = 8.0;
    PCBcutoutH = 7.0;
  } else if (dirSrcSize == 10) {
    activityR = 1.5;
    pSfrontR1 = 2.0;
    pSfrontR2 = 3.0;
    pSfrontH = 3.0;
    pSbackR = 3.0;
    pSbackH = 6.0 - radSrcH;
    fiberGatePosZ = 17.0;
    PCBcutoutH = 4.0;
  }
  const G4double pSfrontZ = bhL - pSfrontH;  // z where inner plastic shielding starts
  // borehole radius where front inner plastic shielding starts
  const G4double pSbhcutR = bhfrontR + (pSfrontZ - frontZ) * (activityR - bhfrontR) / (bhL - frontZ);

  // ============ Build ============
  // outer plastic shell
  const G4int oS_nZP = 5;  // numZPlanes
  const G4double oS_zPlane[oS_nZP] = {0, bhL, 40, 45, 55};
  const G4double oS_rInner[oS_nZP] = {0, 0, 0, 0, 0};
  const G4double oS_rOuter[oS_nZP] = {frontR, srcR, srcR, srcR + 4, srcR + 4};
  G4Polycone *outerShell = new G4Polycone("outerShell", 0, CLHEP::twopi, oS_nZP, oS_zPlane, oS_rInner, oS_rOuter);
  G4LogicalVolume *outerShellLog = new G4LogicalVolume(outerShell, outerShellMaterial, "outerShell");
  G4VPhysicalVolume *outerShellPhys =
      new G4PVPlacement(rotation, position, "outerShell", outerShellLog, motherPhys, false, 0);

  // vacuum/air fill inside outer shell
  // (all remaining volumes will be placed inside this)
  const G4int fill_nZP = 3;
  const G4double fill_zPlane[fill_nZP] = {frontZ, bhL, 45};
  const G4double fill_rInner[fill_nZP] = {0, 0, 0};
  const G4double fill_rOuter[fill_nZP] = {bhfrontR, srcR - 1, srcR - 1};
  G4Polycone *fill = new G4Polycone("dirsource_fill", 0, CLHEP::twopi, fill_nZP, fill_zPlane, fill_rInner, fill_rOuter);
  G4LogicalVolume *fillLog = new G4LogicalVolume(fill, fillMaterial, "dirsource_fill");
  G4VPhysicalVolume *fillPhys = new G4PVPlacement(NULL, zero, "dirsource_fill", fillLog, outerShellPhys, false, 0);

  // fiber gate
  G4Box *fiberGate = new G4Box("fiberGate", 1.2, 1.6, 0.1);
  G4ThreeVector fiberGatePos(0.0, 0.0, fiberGatePosZ);
  G4Material *fiberGateMaterial = G4Material::GetMaterial("polypropylene");
  G4LogicalVolume *fiberGateLog = new G4LogicalVolume(fiberGate, fiberGateMaterial, "fiberGate");
  G4VPhysicalVolume *fiberGatePhys =
      new G4PVPlacement(NULL, fiberGatePos, "fiberGate", fiberGateLog, fillPhys, false, 0);

  // inner metal shield
  const G4int metalFill_nZP = 3;
  const G4double metalFill_zPlane[metalFill_nZP] = {frontZ, bhL, 35};
  const G4double metalFill_rInner[metalFill_nZP] = {0, 0, 0};
  const G4double metalFill_rOuter[metalFill_nZP] = {bhfrontR, srcR - 1, srcR - 1};
  G4Polycone *metalFill =
      new G4Polycone("metalFill", 0, CLHEP::twopi, metalFill_nZP, metalFill_zPlane, metalFill_rInner, metalFill_rOuter);

  const G4int bhCutout_nZP = 8;
  const G4double bhCutout_zPlane[bhCutout_nZP] = {frontZ, pSfrontZ,      pSfrontZ,      bhL,
                                                  bhL,    bhL + radSrcH, bhL + radSrcH, bhL + radSrcH + pSbackH};
  const G4double bhCutout_rInner[bhCutout_nZP] = {0, 0, 0, 0, 0, 0, 0, 0};
  const G4double bhCutout_rOuter[bhCutout_nZP] = {bhfrontR, pSbhcutR, pSfrontR1, pSfrontR2,
                                                  radSrcR,  radSrcR,  pSbackR,   pSbackR};
  G4Polycone *bhCutout =
      new G4Polycone("bhCutout", 0, CLHEP::twopi, bhCutout_nZP, bhCutout_zPlane, bhCutout_rInner, bhCutout_rOuter);

  G4SubtractionSolid *metalBase = new G4SubtractionSolid("metalBase", metalFill, bhCutout, NULL, zero);

  G4Box *SiPMCutout = new G4Box("SiPMcutout", 1.75, 2.4, 1.75);
  G4Box *PCBCutout = new G4Box("PCBcutout", 1.5, 5.25, PCBcutoutH / 2);

  G4MultiUnion *metalCutout = new G4MultiUnion("metalCutout");
  metalCutout->AddNode(SiPMCutout, G4Transform3D(rotm, G4ThreeVector(0.0, 4.0, fiberGatePosZ + 0.45)));
  metalCutout->AddNode(SiPMCutout, G4Transform3D(rotm, G4ThreeVector(0.0, -4.0, fiberGatePosZ + 0.45)));
  metalCutout->AddNode(PCBCutout, G4Transform3D(rotm, G4ThreeVector(0.0, 8.0, fiberGatePosZ + PCBcutoutH / 2 + 2.2)));
  metalCutout->AddNode(PCBCutout, G4Transform3D(rotm, G4ThreeVector(0.0, -8.0, fiberGatePosZ + PCBcutoutH / 2 + 2.2)));
  metalCutout->AddNode(fiberGate, G4Transform3D(rotm, fiberGatePos));
  metalCutout->Voxelize();

  G4SubtractionSolid *metalShield = new G4SubtractionSolid("metalShield", metalBase, metalCutout, NULL, zero);

  G4LogicalVolume *metalShieldLog = new G4LogicalVolume(metalShield, metalShieldMaterial, "metalShield");
  G4VPhysicalVolume *metalShieldPhys = new G4PVPlacement(NULL, zero, "metalShield", metalShieldLog, fillPhys, false, 0);

  // inner plastic shield (front, back)
  const G4int pSf_nZP = 2;
  const G4double pSf_zPlane[pSf_nZP] = {pSfrontZ, bhL};
  const G4double pSf_rInner[pSf_nZP] = {pSbhcutR, activityR};
  const G4double pSf_rOuter[pSf_nZP] = {pSfrontR1, pSfrontR2};
  G4Polycone *plasticShieldFront =
      new G4Polycone("plasticShieldFront", 0, CLHEP::twopi, pSf_nZP, pSf_zPlane, pSf_rInner, pSf_rOuter);
  G4LogicalVolume *plasticShieldFrontLog =
      new G4LogicalVolume(plasticShieldFront, plasticShieldMaterial, "plasticShieldFront");
  G4VPhysicalVolume *plasticShieldFrontPhys =
      new G4PVPlacement(NULL, zero, "plasticShieldFront", plasticShieldFrontLog, fillPhys, false, 0);

  G4Tubs *plasticShieldBack = new G4Tubs("PlasticShieldBack", 0, pSbackR, pSbackH / 2.0, 0, CLHEP::twopi);
  G4ThreeVector pSBackPos(0.0, 0.0, bhL + radSrcH + pSbackH / 2.0);
  G4LogicalVolume *plasticShieldBackLog =
      new G4LogicalVolume(plasticShieldBack, plasticShieldMaterial, "plasticShieldBack");
  G4VPhysicalVolume *plasticShieldBackPhys =
      new G4PVPlacement(NULL, pSBackPos, "plasticShieldBack", plasticShieldBackLog, fillPhys, false, 0);

  // radioactive source (aluminum ring, active area)
  if (dirSrcSize == 30 || dirSrcSize == 20) {
    const G4int srcRing_nZP = 4;
    const G4double srcRing_zPlane[srcRing_nZP] = {bhL, bhL + 1, bhL + radSrcH - 1, bhL + radSrcH};
    const G4double srcRing_rInner[srcRing_nZP] = {radSrcR - 3.5, radSrcR - 4.5, radSrcR - 4.5, radSrcR - 3.5};
    const G4double srcRing_rOuter[srcRing_nZP] = {radSrcR, radSrcR, radSrcR, radSrcR};
    G4Material *srcRingMaterial = G4Material::GetMaterial("aluminum");
    G4Polycone *srcRing =
        new G4Polycone("srcRing", 0, CLHEP::twopi, srcRing_nZP, srcRing_zPlane, srcRing_rInner, srcRing_rOuter);
    G4LogicalVolume *srcRingLog = new G4LogicalVolume(srcRing, srcRingMaterial, "srcRing");
    G4VPhysicalVolume *srcRingPhys = new G4PVPlacement(NULL, zero, "srcRing", srcRingLog, fillPhys, false, 0);
  }  // don't make rad source ring for 10mm source

  G4Tubs *activeArea = new G4Tubs("activeArea", 0, activityR, 0.05, 0, CLHEP::twopi);
  G4ThreeVector activeAreaPos(0.0, 0.0, bhL + radSrcH / 2);
  G4Material *activeAreaMaterial = G4Material::GetMaterial("polypropylene");
  G4LogicalVolume *activeAreaLog = new G4LogicalVolume(activeArea, activeAreaMaterial, "activeArea");
  G4VPhysicalVolume *activeAreaPhys =
      new G4PVPlacement(NULL, activeAreaPos, "dir_source", activeAreaLog, fillPhys, false, 0);

  return NULL;
}  // DirSourceFactory

}  // namespace EOS
