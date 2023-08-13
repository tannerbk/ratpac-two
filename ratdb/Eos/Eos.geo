{
  name: "GEO",
  index: "world",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "",
  type: "box",
  size: [2500.0,2500.0,2500.0],
  material: "air",
}

// Tank dimensions are from docDB-29
{
  name: "GEO",
  index: "outer_tank",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "world",
  type: "tube",
  r_max: 1397.2,
  size_z: 1397.2,
  position: [0.0, 0.0, 0.0],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "inner_tank",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "outer_tank",
  type: "tube",
  r_max: 1371.6,
  size_z: 1371.6,
  position: [0.0, 0.0, 0.0],
  rotation: [0.0, 0.0, 0.0],
  material: "water",
}

{
  name: "GEO",
  index: "outer_neck",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_max: 304.8,
  size_z: 57.2,
  position: [0.0, 0.0, 995.67],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "inner_neck",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_max: 75.3,
  size_z: 55.88,
  position: [0.0, 0.0, 1108.75],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

// Eos dimensions are from docDB-29
{
  name: "GEO",
  index: "eos_vessel",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "eos",
  // Cylindrical part
  r_min: 0.0,
  r_max: 914.4,
  size_z: 676.9,
  // Elliptical top/bottom
  top_radius: 914.4,
  top_height: 261.62,
  offset: 0.1,
  position: [0.0, 0.0, 0.0],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

{
  name: "GEO",
  index: "eos_inner",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "eos_vessel",
  type: "eos",
  // Cylindrical part
  r_min: 0.0,
  // 1-inch thick
  r_max: 888.8,
  size_z: 676.9,
  // Elliptical top/bottom
  top_radius: 888.8,
  top_height: 261.6,
  offset: 0.1,
  rotation:  [0.0, 0.0, 0.0],
  position: [0.0, 0.0, 0.0],
  material: "water",
}

// Acrylic legs dimensions are from docDB-29
{
  name: "GEO",
  index: "bottom_leg1",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 888.8,
  r_max: 914.4,
  phi_start: -20.0,
  phi_delta: 40.0,
  size_z: 80.0,
  position: [0.0, 0.0, -756.9],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

{
  name: "GEO",
  index: "bottom_leg2",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 888.8,
  r_max: 914.4,
  phi_start: 70.0,
  phi_delta: 40.0,
  size_z: 80.0
  position: [0.0, 0.0, -756.9],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

{
  name: "GEO",
  index: "bottom_leg3",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 888.8,
  r_max: 914.4,
  phi_start: 160.0,
  phi_delta: 40.0,
  size_z: 80.0,
  position: [0.0, 0.0, -756.9],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

{
  name: "GEO",
  index: "bottom_leg4",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 888.8,
  r_max: 914.4,
  phi_start: 250.0,
  phi_delta: 40.0,
  size_z: 80.0,
  position: [0.0, 0.0, -756.9],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

{
  name: "GEO",
  index: "top_leg1",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 888.8,
  r_max: 914.4,
  phi_start: -20.0,
  phi_delta: 40.0,
  size_z: 80.0,
  position: [0.0, 0.0, 756.9],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

{
  name: "GEO",
  index: "top_leg2",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 888.8,
  r_max: 914.4,
  phi_start: 70.0,
  phi_delta: 40.0,
  size_z: 80.0,
  position: [0.0, 0.0, 756.9],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

{
  name: "GEO",
  index: "top_leg3",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 888.8,
  r_max: 914.4,
  phi_start: 160.0,
  phi_delta: 40.0,
  size_z: 80.0,
  position: [0.0, 0.0, 756.9],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

{
  name: "GEO",
  index: "top_leg4",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 888.8,
  r_max: 914.4,
  phi_start: 250.0,
  phi_delta: 40.0,
  size_z: 80.0,
  position: [0.0, 0.0, 756.9],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

//////////////////
// PMTS
//////////////////
//

{
  name: "GEO",
  index: "pmts_sides",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "pmtarray",
  pmt_model: "r14688",
  pmt_detector_type: "idpmt",
  sensitive_detector: "/mydet/pmt/inner",
  pos_table: "PMTINFO_sides",
  orientation: "manual",
}

{
name: "GEO",
index: "dichroicons",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "inner_tank",
type: "DichroiconArray",
gdml_file: "gdml/dichroicon_tessellated.gdml",
filter_material: "glass",
base_material:   "acrylic_black",
surface: "shortpass_dichroic_450nm",
filter_color: [1.0, 0.0, 1.0, 0.8],
base_color: [0.4, 0.4, 0.4, 1.0],
base_volumes: ["DICHROICON_BASE"],

pos_table: "DICHROICON_bottom",
orientation: "manual",
offset: -0,
build_absorbing_filter: 1,
// defines the boarder of the PMT
absorbing_filter_zEdge: [ 75.00, 53.06,   0.00, ],
absorbing_filter_rhoEdge: [  0.00, 72.58, 101.00,  ],
absorbing_filter_zOrigin: [-56.00,  0.00,   ],
absorbing_filter_offset: 1.0, // distance from filter to PMT
absorbing_filter_thickness: 1.0,
absorbing_filter_material: "absorbing_longpass_450nm",
absorbing_filter_color: [0.0, 0.187, 0.53, 1.0],
}

{
  name: "GEO",
  index: "pmts_bottom",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "pmtarray",
  pmt_model: "r14688",
  pmt_detector_type: "idpmt",
  sensitive_detector: "/mydet/pmt/inner",
  pos_table: "PMTINFO_bottom",
  orientation: "manual",
}

{
  name: "GEO",
  index: "pmts_top",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "pmtarray",
  pmt_model: "r11780_hqe",
  pmt_detector_type: "idpmt",
  sensitive_detector: "/mydet/pmt/inner",
  pos_table: "PMTINFO_hqe_top",
  orientation: "manual",
}

