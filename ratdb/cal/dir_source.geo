// Directional Beta Source geometry using DirSourceFactory
// to be inserted into Eos detector with mother as "eos_inner"
{
  name: "GEO",
  index: "source_mother",
  valid_begin: [0, 0],
  valid_end: [0, 0],
  mother: "eos_inner",
  type: "DirSource",
  size: 30.0, // options: 30, 20 or 10
  position: [0.0, 0.0, -500.0],
  rotation: [0.0, 0.0, 0.0],

  // properties below are optional;
  // shown below are the default values if omitted.
  // outer_shell_material: "delrin_black",
  // metal_shield_material: "brass", // default is tungsten for 20mm and 10mm sources
  // plastic_shield_material: "delrin_black",
  // fill: "air", // material to fill empty space inside source
  // front_z: 0.15, // borehole front window thickness
}

