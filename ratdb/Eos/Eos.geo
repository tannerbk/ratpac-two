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

{
  name: "GEO",
  index: "outer_tank",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "world",
  type: "tube",
  r_max: 1377.95,
  size_z: 1652.65,
  // Offset to keep AV center at origin (0, 0, 0)
  position: [0.0, 0.0, -169.2],
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
  size_z: 1646.3,
  position: [0.0, 0.0, 0.0],
  rotation: [0.0, 0.0, 0.0],
  material: "water",
}

{
  name: "GEO",
  index: "upper_neck",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_max: 75.3,
  size_z: 149.41,
  position: [0.0, 0.0, 1456.75],
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
  position: [0.0, 0.0, 1251.46],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

{
  name: "GEO",
  index: "outer_neck",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_max: 304.8,
  size_z: 57.15,
  position: [0.0, 0.0, 1138.43],
  rotation: [0.0, 0.0, 0.0],
  // Cloudy acrylic, assume total absorbing
  material: "acrylic_black",
}

// Acrylic vessel dimensions are from docDB-29-v6
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
  size_z: 676.91,
  // Spherical top/bottom
  top_radius: 1724.91,
  top_height: 235.17,
  offset: 0.0,
  // Offset to keep AV center at origin (0, 0, 0)
  position: [0.0, 0.0, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
  build_legs: true,
  // Acrylic legs dimensions are from docDB-29
  leg_height: 160.0,
  leg_n: 4,
  leg_rmin: 888.8,
  leg_phi_start: 0.0,
  leg_phi_delta: 40.0,

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
  size_z: 676.91,
  // Elliptical top/bottom
  top_radius: 1699.51,
  top_height: 209.77,
  offset: 0.0,
  position: [0.0, 0.0, 0.0],
  rotation:  [0.0, 0.0, 0.0],
  material: "water",
}

{
  name: "GEO",
  index: "top_purple_ring",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 888.8,
  r_max: 1041.0,
  size_z: 6.35,
  position: [0.0, 0.0, 1012.46],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "bottom_purple_ring",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 888.8,
  r_max: 1041.0,
  size_z: 6.35,
  position: [0.0, 0.0, -674.06],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut0",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-1104.40, 0.00, 0],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut1",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-1066.77, 285.84, 0],
  rotation: [0.0, 0.0, 15.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut2",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-956.44, 552.20, 0],
  rotation: [0.0, 0.0, 30.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut3",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-780.93, 780.93, 0],
  rotation: [0.0, 0.0, 45.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut4",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-552.20, 956.44, 0],
  rotation: [0.0, 0.0, 60.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut5",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-285.84, 1066.77, 0],
  rotation: [0.0, 0.0, 75.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut6",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-0.00, 1104.40, 0],
  rotation: [0.0, 0.0, 90.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut7",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [285.84, 1066.77, 0],
  rotation: [0.0, 0.0, 105.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut8",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [552.20, 956.44, 0],
  rotation: [0.0, 0.0, 120.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut9",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [780.93, 780.93, 0],
  rotation: [0.0, 0.0, 135.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut10",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [956.44, 552.20, 0],
  rotation: [0.0, 0.0, 150.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut11",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [1066.77, 285.84, 0],
  rotation: [0.0, 0.0, 165.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut12",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [1104.40, 0.00, 0],
  rotation: [0.0, 0.0, 180.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut13",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [1066.77, -285.84, 0],
  rotation: [0.0, 0.0, 195.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut14",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [956.44, -552.20, 0],
  rotation: [0.0, 0.0, 210.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut15",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [780.93, -780.93, 0],
  rotation: [0.0, 0.0, 225.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut16",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [552.20, -956.44, 0],
  rotation: [0.0, 0.0, 240.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut17",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [285.84, -1066.77, 0],
  rotation: [0.0, 0.0, 255.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut18",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [0.00, -1104.40, 0],
  rotation: [0.0, 0.0, 270.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut19",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-285.84, -1066.77, 0],
  rotation: [0.0, 0.0, 285.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut20",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-552.20, -956.44, 0],
  rotation: [0.0, 0.0, 300.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut21",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-780.93, -780.93, 0],
  rotation: [0.0, 0.0, 315.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut22",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-956.44, -552.20, 0],
  rotation: [0.0, 0.0, 330.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "unistrut23",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "box",
  size: [20.0, 20.0, 1483.45],
  position: [-1066.77, -285.84, 0],
  rotation: [0.0, 0.0, 345.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod0",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [-1009.40, 0.00, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod1",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [-874.17, 504.70, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod2",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [-504.70, 874.17, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod3",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [-0.00, 1009.40, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod4",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [504.70, 874.17, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod5",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [874.17, 504.70, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod6",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [1009.40, 0.00, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod7",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [874.17, -504.70, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod8",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [504.70, -874.17, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod9",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [0.00, -1009.40, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod10",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [-504.70, -874.17, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

{
  name: "GEO",
  index: "tierod11",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_min: 0.0,
  r_max: 10.0,
  size_z: 836.9,
  position: [-874.17, -504.70, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}




////////////////
// PMTS
////////////////


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
  type: "DichroiconArray",
  mother: "inner_tank",
  dichroicon_model: "eos_dichroicon",
  pos_table: "PMTINFO_bottom",
  orientation: "manual",
  pmt_type: 1, // build on top of all PMTs if this is not specified.
  offset: 0,
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
  index: "pmts_bottom_back",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "pmtarray",
  pmt_model: "r7081_hqe",
  pmt_detector_type: "idpmt",
  sensitive_detector: "/mydet/pmt/inner",
  pos_table: "PMTINFO_bottom_back",
  orientation: "manual",
}

{
  name: "GEO",
  index: "pmts_top",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "pmtarray",
  pmt_model: "r11780_hqe_rev",
  pmt_detector_type: "idpmt",
  sensitive_detector: "/mydet/pmt/inner",
  pos_table: "PMTINFO_hqe_top",
  orientation: "manual",
}

