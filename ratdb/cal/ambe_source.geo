//
// AmBe container for Eos
//

{ // mother volume to be inserted in Eos, material will be set in macro to match "eos_inner"
  name: "GEO",
  index: "source_mother",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "eos_inner",
  type: "tube",
  r_max: 70.01,
  size_z: 65.01,
  position: [0.0, 0.0, 0.0], // The ambe is centered at [0,0,0] in source_mother
  rotation: [0.0, 0.0, 0.0],
  material: "water",
}

{
  name: "GEO",
  index: "ambe_acrylic_black",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_max: 70.0,
  size_z: 65.0,
  position: [0.0, 0.0, 0.0],
  rotation: [0.0, 0.0, 0.0],
  material: "acrylic_black",
}

{
  name: "GEO",
  index: "ambe_lead",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "ambe_acrylic_black",
  type: "tube",
  r_max: 5.4,
  size_z: 6.5,
  position: [0.0, 0.0, 0.0],
  rotation: [0.0, 0.0, 0.0],
  material: "lead",
}

{
  name: "GEO",
  index: "ambe_steel",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "ambe_lead",
  type: "tube",
  r_max: 3.9,
  size_z: 5.0,
  position: [0.0, 0.0, 0.0],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel_316L",
}

{
  name: "GEO",
  index: "ambe_source",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "ambe_steel",
  type: "tube",
  r_max: 2.5,
  size_z: 2.0,
  position: [0.0, 0.0, 0.0],
  rotation: [0.0, 0.0, 0.0],
  material: "cryostat_vacuum",
}
