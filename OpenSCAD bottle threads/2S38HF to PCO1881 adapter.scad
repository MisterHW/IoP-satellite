use <thread_profile.scad>
use <azimuthal_profile.scad>

$fn = 4*3*16; // 4*3*60 for high res
epsilon = 0.05;

bottle_ID = bottle_2S38HF_neck_clear_dia();
threaded_section_height = 22;
swvnut_total_height = 12;


module adapter_insert()
{
difference()
{
    union()
    {
    translate([0,0,-11+0.5])
    straight_thread(
        section_profile = bottle_pco1881_neck_thread_profile(),
        pitch = bottle_pco1881_neck_thread_pitch(),
        turns = (threaded_section_height-0.5+11-0.5) / bottle_pco1881_neck_thread_pitch() - 0.5,
        r = bottle_pco1881_neck_thread_dia()/2,
        higbee_arc = 10,
        fn = $fn
        );
    rotate_extrude()
        polygon(points=[
        [bottle_pco1881_neck_clear_dia()/2-1,
            -11],
        [bottle_pco1881_neck_thread_dia()/2-0.5,-11],
        [bottle_pco1881_neck_thread_dia()/2+epsilon,-11+0.5],
        [bottle_pco1881_neck_thread_dia()/2+epsilon,
            threaded_section_height-0.5],
        [bottle_pco1881_neck_thread_dia()/2-0.5,
            threaded_section_height],
        [bottle_pco1881_neck_clear_dia()/2-1,
            threaded_section_height]
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
        [bottle_pco1881_nut_thread_major()/2,1.5],
        [bottle_pco1881_nut_thread_major()/2,-11],
        [bottle_2S38HF_neck_clear_dia()/2-1.5,-11],
        [bottle_2S38HF_neck_clear_dia()/2,-11+1.5],
        [bottle_2S38HF_neck_clear_dia()/2,0],
        [bottle_2S38HF_neck_clear_dia()/2+
            bottle_2S38HF_neck_thread_height(),0],
        [bottle_2S38HF_neck_clear_dia()/2+
            bottle_2S38HF_neck_thread_height(),1.5]
    
        ]);
    translate([0,0,-11+0.25])
    straight_thread(
        section_profile = bottle_pco1881_nut_thread_profile(),
        higbee_arc = 10,
        r     = bottle_pco1881_nut_thread_major()/2+epsilon,
        turns = (11+1.5) / bottle_pco1881_nut_thread_pitch()-0.6,
        pitch = bottle_pco1881_nut_thread_pitch(),
        fn    = $fn
    ); 
}
}




module adapter_2S38HF_swivel_nut()
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
        r=bottle_2S38HF_nut_thread_major()/2 +mean_wall_thickness
    );

    translate([0,0,swvnut_total_height-2])
    rotate_extrude()
    polygon(points=[
        [bottle_pco1881_nut_thread_major()/2+1, 0],
        [bottle_2S38HF_nut_thread_major()/2-1, 0],
        [bottle_2S38HF_nut_thread_major()/2, -1],
        [bottle_2S38HF_nut_thread_major()/2, 2],
        [bottle_pco1881_nut_thread_major()/2+1, 2]
    ]);
    for(phi=[0:180:180])
    rotate([0,0,phi])
    translate([0,0,0.25])
    straight_thread(
        section_profile = bottle_2S38HF_nut_thread_profile(),
        r = bottle_2S38HF_nut_thread_major()/2+epsilon,
        pitch = bottle_2S38HF_nut_thread_pitch()*2,
        turns = 0.75,
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
        translate([0,0,-0.25])
            adapter_insert(); 
        translate([0,0,-swvnut_total_height+1.5+2+0.2])
            adapter_2S38HF_swivel_nut();
    }
    translate([0,0,-100])
        cube([100,100,200]);
}
//*/


//// individual parts for export:

// rotate([0,180,0]) adapter_2S38HF_swivel_nut();
// adapter_insert(); 
// rotate([0,180,0]) flanged_nut();

