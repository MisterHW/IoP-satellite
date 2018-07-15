use <thread_profile.scad>
use <azimuthal_profile.scad>

$fn = 4*3*30; // 4*3*60 for high res
epsilon = 0.05;

bottle_ID = bottle_4841_neck_clear_dia();
threaded_section_height = 22;
swvnut_total_height = 15;


module adapter_insert()
{
difference()
{
    union()
    {
    straight_thread(
        section_profile = bottle_pco1881_neck_thread_profile(),
        pitch = bottle_pco1881_neck_thread_pitch(),
        turns = threaded_section_height / bottle_pco1881_neck_thread_pitch() - 0.5,
        r = bottle_pco1881_neck_thread_dia()/2-epsilon,
        higbee_arc = 10,
        fn = $fn
        );
    cylinder(
            r = bottle_pco1881_neck_thread_dia()/2,
            h = threaded_section_height
        );
    translate([0,0,-2]){
        cylinder(
            r = bottle_ID/2,
            h = 2
        );
        translate([0,0,-8]){
            cylinder(
                r2 = bottle_ID/2,
                r1 = bottle_ID/2-1,
                h  = 8
            );
        }
    }
    }

    union()
    {
    cylinder(
        r = bottle_pco1881_neck_clear_dia()/2-1.5, 
        h = 100, 
        center = true
        );
    translate([0,0,-10])
    rotate_extrude()
        polygon(points=[
            [5,-10],
            [bottle_ID/2-4, 0],
            [bottle_ID/2-4, 5],
            [bottle_pco1881_neck_clear_dia()/2-1.5, 9],
            [5,9]
        ]);
    }
}
}

module flanged_nut()
{
union()
{
    rotate_extrude()
        polygon(points=[
        [bottle_pco1881_nut_thread_major()/2, 0],
        [bottle_4841_neck_thread_minor()/2, 0],
        [bottle_4841_neck_thread_minor()/2, 1.5],
        [bottle_pco1881_nut_thread_major()/2 + 3.5, 1.5],
        [bottle_pco1881_nut_thread_major()/2 + 2, 3],
        [bottle_pco1881_nut_thread_major()/2 + 2, 10],
        [bottle_pco1881_nut_thread_major()/2 + 1, 11],
        [bottle_pco1881_nut_thread_major()/2, 11],
        ]);
    straight_thread(
        section_profile = bottle_pco1881_nut_thread_profile(),
        higbee_arc = 10,
        r     = bottle_pco1881_nut_thread_major()/2+epsilon,
        turns = 11 / bottle_pco1881_nut_thread_pitch()-0.6,
        pitch = bottle_pco1881_nut_thread_pitch(),
        fn    = $fn
    ); 
}
}




module adapter_4841_swivel_nut()
{
mean_wall_thickness = 3;
union()
{
    skinned_arc(
        sections = sine_ring_sections(
                        angle = 360, 
                        fn = $fn,
                        offset = mean_wall_thickness,
                        h=swvnut_total_height
                    ),
        angle=360, 
        fn=$fn, 
        r=bottle_4841_nut_thread_major()/2 +mean_wall_thickness
    );

    translate([0,0,swvnut_total_height-2])
    rotate_extrude()
    polygon(points=[
        [bottle_pco1881_nut_thread_major()/2+4, 0],
        [bottle_4841_nut_thread_major()/2-1, 0],
        [bottle_4841_nut_thread_major()/2, -1],
        [bottle_4841_nut_thread_major()/2, 2],
        [bottle_pco1881_nut_thread_major()/2+4, 2]
    ]);
    for(phi=[0:120:240])
    rotate([0,0,phi])
    translate([0,0,1])
    straight_thread(
        section_profile = bottle_4841_nut_thread_profile(),
        r = bottle_4841_nut_thread_major()/2+epsilon,
        pitch = bottle_4841_nut_thread_pitch()*3,
        turns = 0.45,
        higbee_arc = 10,
        fn=$fn
    );
}
}

//// demo:
//*
difference(){
    union()
    {
        rotate([0,0,180])
            flanged_nut();
        adapter_insert(); 
        translate([0,0,-swvnut_total_height+1.5+2+0.2])
            adapter_4841_swivel_nut();
    }
    translate([0,0,-100])
        cube([100,100,200]);
}
//*/


//// individual parts for export:

// rotate([0,180,0]) adapter_4841_swivel_nut();
// adapter_insert(); 
// flanged_nut();

