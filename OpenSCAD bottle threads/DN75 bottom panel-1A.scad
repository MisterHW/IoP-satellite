use <thread_profile.scad>

$fn = 120;
nut_turns = 4.5;
tube_port_bore = 4;

module DN75_endcap(wall_thickness=2, cap_height=32) {
union(){
    d = 75;
    translate([0,0,-wall_thickness])
    cylinder(r=(d+9)/2, h=wall_thickness);

    rotate_extrude()
    polygon(points=[
    [d/2,0],
    [d/2,cap_height-4],
    [d/2-1,cap_height],
    [d/2-wall_thickness,cap_height],
    [d/2-wall_thickness,2],
    [d/2-wall_thickness-2,0]    
    ]);
};
}

union(){
    // generate the base DN75 cap with port(s)
    difference()
    {
    // positive space
    union(){
        DN75_endcap(); 
        // add center riser cylinder
        cylinder(r=16,h=15);
        rotate_extrude() {
          // add fillet to center cylinder 
          polygon(points=[
          [16,0],
          [16+2,0],
          [16,2] ]);  
        };     
    };
    // negative space
    union(){
      // center hole for PET bottle thread
      cylinder(r=27.2/2, h=100, center=true);  
    };
    };
    
// additive internal bottle threads
translate([0,0,-1.5])
straight_thread(
    section_profile = bottle_pco1881_nut_thread_profile(),
    higbee_arc = 20,
    r     = bottle_pco1881_nut_thread_major()/2,
    turns = nut_turns,
    pitch = bottle_pco1881_nut_thread_pitch(),
    fn    = $fn
);

// add cap with port hole
translate([0,0,15-1])
rotate_extrude()
polygon(points=[
    [bottle_pco1881_nut_thread_major()/2, 0],
    [bottle_pco1881_nut_thread_major()/2+1, 0],
    [bottle_pco1881_nut_thread_major()/2+1, 1],
    [tube_port_bore/2+2, 10],
    [tube_port_bore/2+2, 10 + 3],
    [tube_port_bore/2, 10 + 3],
    [tube_port_bore/2, 10]
]);
}



