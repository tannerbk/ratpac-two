//
// Hemispherical Sr90 Cherenkov source for Eos
//

{ // mother volume to be inserted in Eos, material will be set in macro to match "eos_inner"
  name: "GEO",
  index: "source_mother",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "eos_inner",
  type: "tube",
  r_max: 17.5, 
  size_z: 22.0,
  position: [0.0, 0.0, 0.0], // The activity is centered at [0,0,0] in source_mother
  rotation: [0.0, 0.0, 0.0],
  material: "water",
}

// Spherical lower half
{
  name: "GEO",
  index: "sr_acrylic",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "sphere",
  r_max: 17.46,
  theta_start: 90.0,
  theta_delta: 90.0,
  position: [0.0, 0.0, -1.5],
  material: "acrylic_sno",
}

// Cylindrical upper half - outer
{
  name: "GEO",
  index: "sr_acrylic_black_outer",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_min: 7.62,   // larger than sr_steel r_max
  r_max: 17.46,  // same as sr_acrylic sphere
  size_z: 5.56,
  position: [0.0, 0.0, 4.06],  // size_z + sr_acrylic position
  material: "acrylic_black",
}

// Cylindrical upper half - inner
{
  name: "GEO",
  index: "sr_acrylic_black_inner",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_min: 2.5,   // same as sr90 r_max
  r_max: 7.62,  // same as sr_acrylic_black_outer r_min
  size_z: 7.239,
  position: [0.0, 0.0, 8.739],  // size_z + sr_button_gap size_z
  material: "acrylic_black",
}

// Central screw - approximate as a cylinder
{
  name: "GEO",
  index: "sr_screw_central",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_max: 2.5,  // take to be same as sr90 r_max
  size_z: 10.0,
  position: [0.0, 0.0, 11.5],  // size_z + sr_button_gap size_z
  material: "stainless_steel_316L",
}

// Button source gap
{
  name: "GEO",
  index: "sr_button_gap",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_max: 7.62,  // same as sr_acrylic_black_outer r_min
  size_z: 1.5,
  position: [0.0, 0.0, 0.0],
  material: "air",
}

// Sr90 button container
{
  name: "GEO",
  index: "sr_steel_button",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "sr_button_gap",
  type: "tube",
  r_min: 2.5,  // same as sr90 r_max
  r_max: 7.5,
  size_z: 1.5,
  position: [0.0, 0.0, 0.0],
  material: "stainless_steel_316L",
}

// Sr90 active area
{
  name: "GEO",
  index: "sr90",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "sr_steel_button",
  type: "tube",
  r_max: 2.5,
  size_z: 0.05,  // assume cylinder with no window
  position: [0.0, 0.0, 0.0],
  material: "polypropylene",
  color: [6.0, 9.0, 240.0, 0.3],
}
