// Created:   01.08.2023

// Downward facing directional electron source
// Shaved conical top, fully encased in a sealant material

// 1mm diameter exitborehole
// Subgeometries from top (+z) to bottom

{ // mother volume to be inserted in Eos, material will be set in macro to match "eos_inner"
  name: "GEO",
  index: "source_mother",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "",
  type: "box",
  size: [50.0, 50.0, 50.0],
  position: [0.0, 0.0, 0.0], // Make the source exit at z = 0
  rotation: [0.0, 0.0, 0.0],
  material: "cryostat_vacuum",
}

{ //rear sealing, 0.1mm thick around shielding
  name: "GEO",
  index: "rear_seal",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_max: 20.0,
  size_z: 10.0,
  position: [0.0, 0.0, 30.0],
  rotation: [0.0, 0.0, 0.0],
  material: "polypropylene",
}

{ //rear outer shielding, reaches to z=39.9-20
  name: "GEO",
  index: "rear_outershield",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "rear_seal",
  type: "tube",
  r_max: 19.9,
  size_z: 9.95,
  position: [0.0, 0.0, -0.05],
  rotation: [0.0, 0.0, 0.0],
  material: "tungsten",
}

{ //rear inner shielding, reaches to z=39.9-20
  name: "GEO",
  index: "rear_innershield",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "rear_outershield",
  type: "tube",
  r_max: 10.0,
  size_z: 5.0,
  position: [0.0, 0.0, -4.95],
  rotation: [0.0, 0.0, 0.0],
  material: "polypropylene",
}

{ //radioactive source 0.1mm thick z=20.1-20.0
  name: "GEO",
  index: "source",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "rear_innershield",
  type: "tube",
  r_max: 2.5, // from Eckert and Ziegler
  size_z: 0.05,
  position: [0.0, 0.0, -4.95],
  rotation: [0.0, 0.0, 0.0],
  material: "polypropylene",
}

// "Front/Bottom portion"
{ //rear sealing, 0.1mm thick around shielding
  name: "GEO",
  index: "front_seal",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "revolve",
  r_min: [0.0, 0.0],
  r_max: [1.5, 20.0],
  z: [0.0, 20.0],
  position: [0.0, 0.0, 0.0], 
  material: "polypropylene",
}

{ 
  name: "GEO",
  index: "front_outershield",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "front_seal",
  type: "revolve",
  r_min: [0.5, 0.5],//1mm diameter central tube for exit
  r_max: [1.5, 19.9],
  z: [0.1, 20.0],
  position: [0.0, 0.0, 0.0], 
  material: "tungsten",
}

{ 
  name: "GEO",
  index: "front_innershield",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "front_outershield",
  type: "revolve",
  r_min: [0.5, 0.5],//1mm diameter central tube for exit
  r_max: [5.0, 10.0],
  z: [10.0, 20.0],
  position: [0.0, 0.0, 0.0], 
  material: "polypropylene",
}

// Source Exit 1mm diameter
{
  name: "GEO",
  index: "borehole",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "front_seal",
  type: "revolve",
  r_min: [0.0, 0.0]
  r_max: [0.5, 0.5],
  z: [0.1, 20.0],
  position: [0.0, 0.0, 0.0],
  material: "cryostat_vacuum",
  color: [13.0, 255.0, 60.0, 1.0]
}

{ // scintillating fiber gate
  name: "GEO",
  index: "fiber",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "borehole",
  type: "tube",
  r_max: 0.5,
  size_z: 0.1,
  position: [0.0, 0.0, 0.4],
  rotation: [0.0, 0.0, 0.0],
  material: "cryostat_vacuum",
  color: [13.0, 153.0, 255.0, 1.0],
}

