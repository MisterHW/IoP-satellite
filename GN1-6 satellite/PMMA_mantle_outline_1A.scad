function sum(l, first, last, res=0) = 
    first == last ?  res + l[last] : sum(l, first+1, last, res+l[first]);

function arc_shortening(r, phi) = 
    2*r*tan(phi/2) - r*phi*PI/180;
    
/*  seam
 1__v__2
 /     \ facet
|       |
|       | short
 \_____/
  long

*/
long_outer_side  = 119;
long_outer_side_part1 = long_outer_side * 0.5;
long_outer_side_part2 = long_outer_side * 0.5;

short_outer_side  = 104;
facet_outer_side  = 31;
thickness = 2;
// assume outside (colder) remains mostly unstretched?
bend_correction = -arc_shortening(5, 45);
height = 199;// 230;
cutout_radius   = 3;
cutout_offset_y = 1.5;


    
total_length = 
    long_outer_side_part1 + long_outer_side_part2 + long_outer_side + 
    2 * short_outer_side + 
    4 * facet_outer_side +
    8 * bend_correction;
    
echo("dimensions = ", [total_length, height]);    

bend_cutout_spacing = [
    long_outer_side_part1 + 0.5 * bend_correction,
    facet_outer_side + bend_correction,
    short_outer_side + bend_correction,
    facet_outer_side + bend_correction,
    long_outer_side  + bend_correction,
    facet_outer_side + bend_correction,
    short_outer_side + bend_correction,
    facet_outer_side + bend_correction,
];

mirror([1,0,0]) rotate([0,0,90])
difference(){
    square(size=[total_length, height]);
    union(){
        for (i=[0:len(bend_cutout_spacing)-1]){
           x = sum(bend_cutout_spacing,0,i);
           echo(x);
           translate([x,-cutout_offset_y]) 
                circle(cutout_radius, $fn=30); 
           translate([x,height+cutout_offset_y]) 
                circle(cutout_radius, $fn=30);
        }
    }
}