// Directional Beta Source geometry using DirSourceFactory
// to be inserted into Eos detector with mother as "eos_inner"
{
  name: "GEO",
  index: "source_mother",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "eos_inner",
  type: "DirSource",
  position: [0.0, 0.0, -500.0],
  rotation: [0.0, 0.0, 0.0],
  outer_shell_material: "delrin_black",
  metal_shield_material: "brass",
  plastic_shield_material: "delrin_black",

  // properties below are optional;
  // shown below are the default values if omitted.
  // fill: "air", // material to fill empty space inside source
  // front_z: 0.15, // borehole front window thickness
}

