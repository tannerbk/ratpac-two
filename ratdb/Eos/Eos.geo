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
  index: "outer_neck",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "inner_tank",
  type: "tube",
  r_max: 304.8,
  size_z: 57.2,
  position: [0.0, 0.0, 1164.87],
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
  position: [0.0, 0.0, 1277.95],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
}

// Acrylic vessel dimensions are from docDB-29
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
  // Offset to keep AV center at origin (0, 0, 0)
  position: [0.0, 0.0, 169.2],
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
  r_max: 1041.0
  size_z: 6.35,
  position: [0.0, 0.0, 1006.1],
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
  position: [0.0, 0.0, -667.7],
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
  position: [-1104.40, 0.00, 169.2],
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
  position: [-1066.77, 285.84, 169.2],
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
  position: [-956.44, 552.20, 169.2],
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
  position: [-780.93, 780.93, 169.2],
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
  position: [-552.20, 956.44, 169.2],
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
  position: [-285.84, 1066.77, 169.2],
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
  position: [-0.00, 1104.40, 169.2],
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
  position: [285.84, 1066.77, 169.2],
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
  position: [552.20, 956.44, 169.2],
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
  position: [780.93, 780.93, 169.2],
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
  position: [956.44, 552.20, 169.2],
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
  position: [1066.77, 285.84, 169.2],
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
  position: [1104.40, 0.00, 169.2],
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
  position: [1066.77, -285.84, 169.2],
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
  position: [956.44, -552.20, 169.2],
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
  position: [780.93, -780.93, 169.2],
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
  position: [552.20, -956.44, 169.2],
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
  position: [285.84, -1066.77, 169.2],
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
  position: [0.00, -1104.40, 169.2],
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
  position: [-285.84, -1066.77, 169.2],
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
  position: [-552.20, -956.44, 169.2],
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
  position: [-780.93, -780.93, 169.2],
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
  position: [-956.44, -552.20, 169.2],
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
  position: [-1066.77, -285.84, 169.2],
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
  r_max: 10.0
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
  r_max: 10.0
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
  r_max: 10.0
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
  r_max: 10.0
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
  r_max: 10.0
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
  r_max: 10.0
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
  r_max: 10.0
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
  r_max: 10.0
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
  r_max: 10.0
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
  r_max: 10.0
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
  r_max: 10.0
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
  r_max: 10.0
  size_z: 836.9,
  position: [-874.17, -504.70, 169.2],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel",
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
  position: [0.0, 0.0, -587.7],
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
  position: [0.0, 0.0, -587.7],
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
  position: [0.0, 0.0, -587.7],
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
  position: [0.0, 0.0, -587.7],
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
  position: [0.0, 0.0, 926.1],
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
  position: [0.0, 0.0, 926.1],
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
  position: [0.0, 0.0, 926.1],
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
  position: [0.0, 0.0, 926.1],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_sno",
}

//////////////////
// PMTS
//////////////////
//

/*
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
*/

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
  pmt_model: "r11780_hqe",
  pmt_detector_type: "idpmt",
  sensitive_detector: "/mydet/pmt/inner",
  pos_table: "PMTINFO_hqe_top",
  orientation: "manual",
}

