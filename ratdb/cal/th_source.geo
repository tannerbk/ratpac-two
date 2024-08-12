//
// Cyliondrical Th rod source for Eos
//

{ // mother volume to be inserted in Eos, material will be set in macro to match "eos_inner"
  name: "GEO",
  index: "source_mother",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "eos_inner",
  type: "tube",
  r_max: 13.526,
  size_z: 101.886,  // tube half-height + top height + offset (87.6 + 11.11 + 3.175 = 101.885)
  position: [0.0, 0.0, 0.0], // The activity is centered at [0,0,0] in source_mother
  rotation: [0.0, 0.0, 0.0],
  material: "water",
}

// Cylindrical hollow tube
{
  name: "GEO",
  index: "th_delrin_black_tube",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_max: 13.525,
  r_min: 10.515,
  size_z: 87.6,  // match th_air volume
  position: [0.0, 0.0, 3.175],  // top - bot size_z = (11.11-4.76)/2 = 3.175
  material: "delrin_black",
}

// Cylindrical cap top
{
  name: "GEO",
  index: "th_delrin_black_top",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_max: 13.525,
  size_z: 5.555,  // 11.11/2 mm
  position: [0.0, 0.0, 96.33],  // tube size_z + tube position (87.6+3.175) + top size_z
  material: "delrin_black",
}

// Cylindrical cap bottom
{
  name: "GEO",
  index: "th_delrin_black_bot",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "source_mother",
  type: "tube",
  r_max: 13.525,
  size_z: 2.38,  // 4.76/2 mm
  position: [0.0, 0.0, -86.805],  // -tube size_z + tube position (-87.6+3.175) - bottom size_z
  material: "delrin_black",
}

// Internal air volume
{
  name: "GEO",
  index: "th_air",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "th_delrin_black_tube",
  type: "tube",
  r_max: 10.515,
  size_z: 87.6, // 175/2+0.1 
  position: [0.0, 0.0, -3.175],  // negative of th_delrin_black_tube offset
  material: "air",
}

// 4%-thoriated tungsten rods (4.8-mm diameter)
// https://diamondground.com/shop/4-thoriated-orange/
// FIXME: assumes a tungsten tube instead of 10 rods in a ring
{
  name: "GEO",
  index: "th_rods",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "th_air",
  type: "tube",
  r_min: 5.71,
  r_max: 10.51,
  size_z: 87.5,
  position: [0.0, 0.0, 0.0],
  material: "tungsten",
  color: [6.0, 9.0, 240.0, 0.3],
}
