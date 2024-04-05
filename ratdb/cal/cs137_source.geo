//
// Cs container for Eos
//

{ // mother volume to be inserted in Eos, material will be set in macro to match "eos_inner"
  name: "GEO",
  index: "source_mother",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "eos_inner",
  type: "tube",
  r_max: 1.51,
  size_z: 5.56,
  position: [0.0, 0.0, 0.0], // The cs137 is centered at [0,0,0] in source_mother
  rotation: [0.0, 0.0, 0.0],
  material: "water",
}

{
  name: "GEO",
  index: "cs_steel",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_max: 1.5,
  size_z: 3.05,
  position: [0.0, 0.0, 2.50],
  material: "stainless_steel_316L",
}

{
  name: "GEO",
  index: "cs_epoxy",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "cs_steel",
  type: "tube",
  r_max: 1.0,
  size_z: 2.0,
  position: [0.0, 0.0, -0.55], // shift down to keep 0.5 cs_steel thickness at bottom
  material: "acrylic_black", // placeholder for epoxy
}

{
  name: "GEO",
  index: "cs137",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "cs_epoxy",
  type: "tube",
  r_max: 1.0,
  size_z: 0.05, // thin layer at bottom, assume none on walls
  position: [0.0, 0.0, -1.95], // shift down to bottom of cs_epoxy
  material: "cryostat_vacuum",
  color: [6.0, 9.0, 240.0, 0.3],
}
