use <thread_profile.scad>
use <azimuthal_profile.scad>

$fn = 4*30;

bottle_ID = bottle_4841_neck_bore();
threaded_section_height = 22;

module adapter_insert()
{
difference()
{
    union()
    {
    straight_thread(
        section_profile = pco1881_neck_thread_profile(),
        pitch = pco1881_neck_thread_pitch(),
        turns = threaded_section_height / pco1881_neck_thread_pitch() - 0.5,
        r = pco1881_neck_thread_dia()/2,
        higbee_arc = 10,
        fn = $fn
        );
    cylinder(
            r = pco1881_neck_thread_dia()/2,
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
        r = pco1881_neck_bore()/2-1.5, 
        h = 100, 
        center = true
        );
    translate([0,0,-10])
    rotate_extrude()
        polygon(points=[
            [5,-10],
            [bottle_ID/2-4, 0],
            [bottle_ID/2-4, 5],
            [pco1881_neck_bore()/2-1.5, 9],
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
        [pco1881_nut_thread_dia()/2, 0],
        [bottle_4841_neck_dia()/2, 0],
        [bottle_4841_neck_dia()/2, 1.5],
        [pco1881_nut_thread_dia()/2 + 3.5, 1.5],
        [pco1881_nut_thread_dia()/2 + 2, 3],
        [pco1881_nut_thread_dia()/2 + 2, 10],
        [pco1881_nut_thread_dia()/2 + 1, 11],
        [pco1881_nut_thread_dia()/2, 11],
        ]);
    straight_thread(
        section_profile = pco1881_nut_thread_profile(),
        higbee_arc = 10,
        r     = pco1881_nut_thread_dia()/2,
        turns = 11 / pco1881_nut_thread_pitch()-0.5,
        pitch = pco1881_nut_thread_pitch(),
        fn    = $fn
    ); 
}
}




module adapter_4841_swivel_nut()
{
    // todo
}





difference(){
    union()
    {
        rotate([0,0,180])
            flanged_nut();
        adapter_insert();
        adapter_4841_swivel_nut();
    }
    translate([0,0,-100])
        cube([100,100,200]);
}


