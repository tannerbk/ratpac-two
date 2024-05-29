//
// PuBe container outside Eos
//

{ // mother volume to be just outside Eos detector
  name: "GEO",
  index: "source_mother",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "world",
  type: "tube",
  r_max: 17.01,
  size_z: 30.01,
  position: [-1573.0, 0.0, 0.0], // The pube is centered at [0,0,0] in source_mother
  rotation: [0.0, 0.0, 0.0],
  material: "air",
}

{
  name: "GEO",
  index: "pube_steel",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_max: 17.0,
  size_z: 30.0,
  position: [0.0, 0.0, 0.0],
  rotation: [0.0, 0.0, 0.0],
  material: "stainless_steel_316L",
}

{
  name: "GEO",
  index: "pube_source",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "pube_steel",
  type: "tube",
  r_max: 11.1,
  size_z: 15.9,
  position: [0.0, 0.0, 0.0],
  rotation: [0.0, 0.0, 0.0],
  material: "cryostat_vacuum",
}
