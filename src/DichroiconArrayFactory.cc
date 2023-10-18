/**********************************************************************
 * Filename:   DichroiconArrayFactory
 * Author:     James Shen <jierans@sas.upenn.edu>
 * Date:       8/8/23 1:51 PM
 **********************************************************************/
#include <DichroiconArrayFactory.hh>
#include <G4GDMLParser.hh>
#include <G4LogicalSkinSurface.hh>
#include <G4Material.hh>
#include <G4PVPlacement.hh>
#include <RAT/GLG4TorusStack.hh>
#include <RAT/Log.hh>
#include <RAT/Materials.hh>

namespace EOS {
G4VPhysicalVolume *DichroiconArrayFactory::Construct(RAT::DBLinkPtr table) {
  std::string volume_name = table->GetS("index");
  std::string mother_name = table->GetS("mother");
  // setup position arrays
  std::string pos_table_name = table->GetS("pos_table");
  RAT::DBLinkPtr pos_table = RAT::DB::Get()->GetLink(pos_table_name);
  const std::vector<double> &pos_x = pos_table->GetDArray("x");
  const std::vector<double> &pos_y = pos_table->GetDArray("y");
  const std::vector<double> &pos_z = pos_table->GetDArray("z");
  std::vector<G4ThreeVector> pmt_positions(pos_x.size());
  for (int i = 0; i < pos_x.size(); i++) {
    pmt_positions[i] = G4ThreeVector(pos_x[i], pos_y[i], pos_z[i]);
  }
  // setup orientation arrays
  bool orient_manual = false;
  try {
    std::string orient_str = table->GetS("orientation");
    if (orient_str == "manual")
      orient_manual = true;
    else if (orient_str == "point")
      orient_manual = false;
    else
      RAT::Log::Die("Dichroicon Factory error: Unknown orientation " + orient_str);
  } catch (RAT::DBNotFoundError &e) {
  }
  std::vector<G4ThreeVector> pmt_directions(pmt_positions.size());
  if (!orient_manual) {
    const std::vector<double> &orient_point_array = table->GetDArray("orient_point");
    if (orient_point_array.size() != 3) RAT::Log::Die("Dichroicon Factory Error: orient_point must have 3 values");
    const G4ThreeVector orient_point(orient_point_array[0], orient_point_array[1], orient_point_array[2]);
    for (int i = 0; i < pmt_positions.size(); i++) {
      pmt_directions[i] = (orient_point - pmt_positions[i]).unit();
    }
  } else {
    const std::vector<double> &dir_x = pos_table->GetDArray("dir_x");
    const std::vector<double> &dir_y = pos_table->GetDArray("dir_y");
    const std::vector<double> &dir_z = pos_table->GetDArray("dir_z");
    RAT::Log::Assert(pos_x.size() == pos_y.size() && pos_x.size() == pos_z.size(),
                     "Dichroicon position arrays must be the same length");
    RAT::Log::Assert(
        pos_x.size() == dir_x.size() && pmt_positions.size() == dir_y.size() && pmt_positions.size() == dir_z.size(),
        "Dichroicon direction arrays must be the same length");
    for (int i = 0; i < pos_x.size(); i++) {
      pmt_directions[i] = G4ThreeVector(dir_x[i], dir_y[i], dir_z[i]).unit();
    }
  }
  // pick out a pmt type
  std::vector<G4ThreeVector> dichroicon_positions;
  std::vector<G4ThreeVector> dichroicon_directions;
  bool type_specified = false;
  try {  // if pmt_type is specified
    int pmt_type_to_build = table->GetI("pmt_type");
    type_specified = true;
    std::vector<int> pmt_type;
    try {
      pmt_type = pos_table->GetIArray("type");
    } catch (RAT::DBNotFoundError &e) {
      RAT::Log::Die("Dichroicon Factory Error: pmt_type specified but not found in pos_table");
    }

    for (int i = 0; i < pmt_type.size(); i++) {
      if (pmt_type[i] == pmt_type_to_build) {
        dichroicon_positions.push_back(pmt_positions[i]);
        dichroicon_directions.push_back(pmt_directions[i]);
      }
    }
  } catch (RAT::DBNotFoundError &e) {
    dichroicon_positions = pmt_positions;
    dichroicon_directions = pmt_directions;
  }

  // compute positional offset
  double offset = 0;
  try {
    offset = table->GetD("offset");
  } catch (RAT::DBNotFoundError &e) {
  }
  for (int i = 0; i < dichroicon_positions.size(); i++) {
    dichroicon_positions[i] += offset * dichroicon_directions[i];
  }

  ConstructDichroicons(table, dichroicon_positions, dichroicon_directions);
  return nullptr;
}

void DichroiconArrayFactory::ConstructDichroicons(RAT::DBLinkPtr table, const std::vector<G4ThreeVector> &pos,
                                                  const std::vector<G4ThreeVector> &dir) {
  RAT::Log::Assert(pos.size() == dir.size(), "Dichroicon position and direction arrays must be the same length");
  const std::string volumeName = table->GetIndex();

  const std::string motherName = table->GetS("mother");
  RAT::DBLinkPtr dichroicon_model_table;
  try {
    const std::string dichroicon_model_name = table->GetS("dichroicon_model");
    dichroicon_model_table = RAT::DB::Get()->GetLink("DICHROICONS", dichroicon_model_name);
  } catch (RAT::DBNotFoundError &e) {
    RAT::Log::Die("Dichroicon model not specified");
  }
  G4Material *filter_material = G4Material::GetMaterial(dichroicon_model_table->GetS("dichroic_filter_material"));
  G4Material *base_material = G4Material::GetMaterial(dichroicon_model_table->GetS("base_material"));
  G4Material *absorbing_filter_material =
      G4Material::GetMaterial(dichroicon_model_table->GetS("absorbing_filter_material"));
  const std::string surface_name = dichroicon_model_table->GetS("dichroic_surface");
  const std::vector<std::string> base_volumes = dichroicon_model_table->GetSArray("base_volumes");

  G4VPhysicalVolume *motherPhys = FindPhysMother(motherName);
  if (motherPhys == nullptr) RAT::Log::Die("Dichroicon mother physical volume not found: " + motherName);
  G4GDMLParser parser;
  const G4String gdml_file =
      std::getenv("EOSDATA") + std::string("/ratdb/") + dichroicon_model_table->GetS("gdml_file");
  //  parser.SetOverlapCheck(true);
  parser.Read(gdml_file);
  G4LogicalVolume *gdml_worldLV = parser.GetWorldVolume()->GetLogicalVolume();
  const size_t n_gdml_daughters = gdml_worldLV->GetNoDaughters();
  // absorbing filter
  int build_absorbing_filter = 0;
  try {
    build_absorbing_filter = dichroicon_model_table->GetI("build_absorbing_filter");
  } catch (RAT::DBNotFoundError &e) {
  }
  G4LogicalVolume *absorbing_filter_lv = nullptr;
  if (build_absorbing_filter) {
    std::vector<double> zOrigin = dichroicon_model_table->GetDArray("absorbing_filter_zOrigin");
    std::vector<double> zEdge = dichroicon_model_table->GetDArray("absorbing_filter_zEdge");
    std::vector<double> rhoEdge = dichroicon_model_table->GetDArray("absorbing_filter_rhoEdge");
    RAT::Log::Assert(zEdge.size() == rhoEdge.size(),
                     "Dichroicon absorbing filter zEdge and rhoEdge arrays must be the same length");
    RAT::Log::Assert(zEdge.size() == zOrigin.size() + 1,
                     "Dichroicon absorbing filter zEdge length must be one greater than zOrigin length");
    std::vector<double> zOrigin_inner(zOrigin.size());
    std::vector<double> zEdge_inner(zEdge.size());
    std::vector<double> rhoEdge_inner(rhoEdge.size());
    std::vector<double> zOrigin_outer(zOrigin.size());
    std::vector<double> rhoEdge_outer(rhoEdge.size());
    std::vector<double> zEdge_outer(zEdge.size());
    double filter_offset = dichroicon_model_table->GetD("absorbing_filter_offset");
    double filter_thickness = dichroicon_model_table->GetD("absorbing_filter_thickness");
    // the inner surface of the filter has the same shape as the PMT glass, just shifted by `filter_offset` in the z
    // direction. The outer surface is constructed based on the inner surface, such that the thickness normal to the
    // inner surface equals `absorbing_filter_thickness` Algorithm for cosntructing the outer surface:
    // https://github.com/rat-pac/ratpac-two/blob/b8121abe14601ac842f09be978804af42b4ecb26/src/geo/src/pmt/ToroidalPMTConstruction.cc#L378-L398
    if (zEdge[zEdge.size() - 1] != 0.0)
      RAT::warn << "Absorbing filter construction implicitly assumes the z coordinate of the last point is 0. Shape of "
                   "the filter (especially towards the edge) may be bad!"
                << newline;
    for (int i = 0; i < zOrigin.size(); i++) {
      zOrigin_inner[i] = zOrigin[i] + filter_offset;
    }
    for (int i = 0; i < zEdge.size(); i++) {
      zEdge_inner[i] = zEdge[i] + filter_offset;
      rhoEdge_inner[i] = rhoEdge[i];
    }
    auto absorbing_filter_inner = new GLG4TorusStack("absorbing_filter_inner");
    absorbing_filter_inner->SetAllParameters((int)zOrigin_inner.size(), zEdge_inner.data(), rhoEdge_inner.data(),
                                             zOrigin_inner.data());
    // outer surface parameters
    zOrigin_outer = zOrigin_inner;
    G4ThreeVector norm;
    zEdge_outer[0] = zEdge_inner[0] + filter_thickness;
    rhoEdge_outer[0] = 0.0;
    for (int i = 1; i < zEdge.size() - 1; i++) {
      norm = absorbing_filter_inner->SurfaceNormal(G4ThreeVector(0.0, rhoEdge_inner[i], zEdge_inner[i]));
      zEdge_outer[i] = zEdge_inner[i] + filter_thickness * norm.z();
      rhoEdge_outer[i] = rhoEdge_inner[i] + filter_thickness * norm.y();
    }
    rhoEdge_outer[rhoEdge.size() - 1] = rhoEdge_inner[rhoEdge.size() - 1] + filter_thickness;
    zEdge_outer[zEdge.size() - 1] = zEdge_inner[rhoEdge.size() - 1];

    auto absorbing_filter = new GLG4TorusStack("absorbing_filter");
    absorbing_filter->SetAllParameters((int)zOrigin_outer.size(), zEdge_outer.data(), rhoEdge_outer.data(),
                                       zOrigin_outer.data(), absorbing_filter_inner);
    absorbing_filter_lv = new G4LogicalVolume(absorbing_filter, absorbing_filter_material, "absorbing_filter_log");
    SetVis(absorbing_filter_lv, dichroicon_model_table->GetDArray("absorbing_filter_color"));
  }

  // loop through pos and dir
  for (int i_dichroicon = 0; i_dichroicon < pos.size(); i_dichroicon++) {
    // compute required rotation
    const G4ThreeVector &current_pmt_pos = pos[i_dichroicon];
    const G4ThreeVector &current_pmt_dir = dir[i_dichroicon];
    double angle_y = (-1.0) * atan2(current_pmt_dir.x(), current_pmt_dir.z());
    double angle_x = atan2(current_pmt_dir.y(),
                           sqrt(current_pmt_dir.x() * current_pmt_dir.x() + current_pmt_dir.z() * current_pmt_dir.z()));
    auto *rotation = new G4RotationMatrix();
    rotation->rotateY(angle_y);
    rotation->rotateX(angle_x);
    // loop through gdml daughters
    for (int i_component = 0; i_component < n_gdml_daughters; i_component++) {
      G4VPhysicalVolume *daughter = gdml_worldLV->GetDaughter(i_component);
      // create copy of daughter

      G4String name = daughter->GetName();
      G4LogicalVolume *daughter_lv = daughter->GetLogicalVolume();
      name = name.substr(3);
      G4String placed_name;
      bool is_base = std::find(base_volumes.begin(), base_volumes.end(), name) != base_volumes.end();
      if (is_base) {
        daughter_lv->SetMaterial(base_material);
        SetVis(daughter_lv, dichroicon_model_table->GetDArray("base_color"));
        placed_name = "dichroicon_base";
      } else {
        daughter_lv->SetMaterial(filter_material);
        SetVis(daughter_lv, dichroicon_model_table->GetDArray("dichroic_filter_color"));
        if (RAT::Materials::optical_surface.count(surface_name) == 0)
          RAT::warn << "DichroiconArrayFactory error: " << surface_name
                    << " is not a valid surface. No surface will be added!!" << newline;
        else
          new G4LogicalSkinSurface(name + "_surface", daughter_lv, RAT::Materials::optical_surface[surface_name]);
        placed_name = "dichroic_filter";
      }
      G4VPhysicalVolume *daughterPhys =
          new G4PVPlacement(rotation, current_pmt_pos, placed_name, daughter_lv, motherPhys, false, 0);
    }
    if (build_absorbing_filter) {
      G4VPhysicalVolume *absorbing_filter_phys =
          new G4PVPlacement(rotation, current_pmt_pos, "absorbing_filter", absorbing_filter_lv, motherPhys, false, 0);
    }
  }
}

void DichroiconArrayFactory::SetVis(G4LogicalVolume *volume, const std::vector<double> &color) {
  G4VisAttributes *att = GetColor(color);
  //  att->SetForceSolid(true);
  volume->SetVisAttributes(att);
}

// This really should be available to all factories
G4VisAttributes *DichroiconArrayFactory::GetColor(const std::vector<double> &color) {
  if (color.size() == 4) {
    return new G4VisAttributes(G4Color(color[0], color[1], color[2], color[3]));
  } else if (color.size() == 3) {
    return new G4VisAttributes(G4Color(color[0], color[1], color[2]));
  } else {
    return new G4VisAttributes(G4Color());
  }
}

}  // namespace EOS
