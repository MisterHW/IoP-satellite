use <thread_profile.scad>

$fn = 120;
insert_offset = 20;
insert_drill_dia = 6;
nut_turns  = 3.5;
nut_height = 12.5;
tube_od = 4;

module center_and_single_mount_2d() {
hull(){
    rotate([0,0,-45]) 
    square(size=16);
    
    translate([insert_offset,0,0]) 
    circle(r=5);
};
}

module center_support_solid() {
smooth_displacement = 15;
linear_extrude(nut_height)
    offset(-smooth_displacement) 
    offset( smooth_displacement)
    union(){
    for (i=[0:90:270]) 
        rotate([0,0,i]) 
        center_and_single_mount_2d();
    };
}

union(){
straight_thread(
    section_profile = bottle_pco1881_nut_thread_profile(),
    higbee_arc = 20,
    r     = bottle_pco1881_nut_thread_major()/2,
    turns = nut_turns,
    pitch = bottle_pco1881_nut_thread_pitch(),
    fn    = $fn
);    
difference(){
    center_support_solid();
    union(){
        cylinder(r=bottle_pco1881_nut_thread_major()/2, h=100, center=true);
        for (i=[0:90:270]) 
            rotate([0,0,i]) 
            translate([insert_offset,0,0]) 
            cylinder(r=insert_drill_dia/2, h=100, center=true);
    }    
};

translate([0,0,nut_height-1])
rotate_extrude()
polygon(points=[
    [bottle_pco1881_nut_thread_major()/2, 0],
    [bottle_pco1881_nut_thread_major()/2+1, 0],
    [bottle_pco1881_nut_thread_major()/2+1, 1],
    [tube_od/2+2, 10],
    [tube_od/2+2, 10 + 3],
    [tube_od/2, 10 + 3],
    [tube_od/2, 10]
]);

}

