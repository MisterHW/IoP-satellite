ports_circle_radius = 15;
port_dia = 3;
port_spacing_degrees = 40;
disc_radius = 22.5;
cavity_radius = 23;
a = 60;
magnet_hole_dia = 8.2;

top_plate_thickness = 6;
center_plate_thickness = 2;
bottom_plate_thickness = 2;

module pip(wall_thickness =0.3, pip_length=18)
{
    color([0.5,0.5,1,0.8])
    linear_extrude(pip_length)
    difference()
    {
        circle(d=port_dia, $fn=32);
        circle(d=port_dia-wall_thickness*2, $fn=32);    
    };
};

module square_hole_pattern(mounting_hole_dist = 46, mount_hole_dia = 4.5)
{
    for(i=[0:3]){
              rotate(90*i+45)
              translate([0,mounting_hole_dist/2*sqrt(2)])
              circle(d=mount_hole_dia, $fn=32);  
            };
};

module top_plate()
{
    color([1,1,0,0.5])
    linear_extrude(top_plate_thickness)
    difference(){
        square([a,a], center=true);
        for(phi=[0,180+port_spacing_degrees/2])
        for(i=[0:3]){
          rotate(port_spacing_degrees*i+phi)
          translate([ports_circle_radius,0])
          circle(d=port_dia, $fn=32);  
        };
        circle(d=port_dia, $fn=32); 
        square_hole_pattern();
    };
    
};

module center_spacer_plate()
{
    color([1,0.5,0,0.5])
    linear_extrude(center_plate_thickness) 
     difference(){
        square([a,a], center=true);
        circle(cavity_radius, $fn=120);
        square_hole_pattern();
    };   
};

module channel_disc()
{
    color([0,0.5,0.5,0.5])
    linear_extrude(center_plate_thickness) 
     difference(){
        circle(disc_radius, $fn=120);
        hull(){
            translate([ ports_circle_radius,0]) circle(d=port_dia+1, $fn=32);
            translate([-ports_circle_radius,0]) circle(d=port_dia+1, $fn=32);
        } 
        translate([0,10]) circle(d=magnet_hole_dia, $fn=120);
        translate([0,-10]) circle(d=magnet_hole_dia, $fn=120);
    };       
};


module bottom_plate()
{
    color([1,1,0,0.5])
    linear_extrude(bottom_plate_thickness)
    difference(){
        square([a,a], center=true);
        square_hole_pattern();
    };
    
};



translate([0,0,bottom_plate_thickness + 0.1 + center_plate_thickness+0.1]){
        top_plate();
        pip();
        for(phi=[0,180+port_spacing_degrees/2])
            for(i=[0:3]){
              rotate(port_spacing_degrees*i+phi)
              translate([ports_circle_radius,0])
              pip(); 
            };
}
translate([0,0,bottom_plate_thickness + 0.1]) { center_spacer_plate();
    channel_disc();
};
bottom_plate();