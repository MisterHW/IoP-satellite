use <scad-utils/transformations.scad>    // https://github.com/openscad/scad-utils
use <list-comprehension-demos/skin.scad> // https://github.com/openscad/list-comprehension-demos

// radial scaling function for tapered lead-in and lead-out
function lilo_taper(x,N,tapered_fraction) = 
    min( min( 1, (1.0/tapered_fraction)*(x/N) ), (1/tapered_fraction)*(1-x/N) )
;

// helical thread with higbee cut at start and end
// to be attached to a cylindrical surface with matching $fn
module straight_thread(section_profile, pitch = 4, turns = 3, r=10, higbee_arc=45, fn=120)
{
	$fn = fn;
	steps = turns*$fn;
	thing =  [ for (i=[0:steps])
		transform(
			rotation([0, 0, 360*i/$fn - 90])*
			translation([0, r, pitch*i/$fn])*
			rotation([90,0,0])*
			rotation([0,90,0])*
			scaling([0.01+0.99*
			lilo_taper(i/turns,steps/turns,(higbee_arc/360)/turns),1,1]),
			section_profile
			)
		];
	skin(thing);
}

// demo: straight_thread(section_profile=demo_thread_profile());
function demo_thread_profile() = [
    [0,0],
    [1.5,1],
    [1.5,1],
    [0,3],
    [-1,3],
    [-1,0]    
];

// PCO-1881 soda bottle cap thread (estimated from bottle thread dims)
function pco1881_nut_thread_dia()     = 27.4; 
function pco1881_nut_thread_pitch()   = 2.7;
function pco1881_nut_thread_profile() = [
    [0,0],
    [-1.15,0.22],
    [-1.15,1.22],
    [0,1.42]
];

// PCO-1881 soda bottle neck thread
function pco1881_neck_bore() = 21.74;
function pco1881_neck_thread_dia()     = 24.94;
function pco1881_neck_thread_pitch()   = 2.7;
function pco1881_neck_thread_profile() = [
    [0,0],
    [0,1.42],
    [1.15,1.22],
	[1.15,0.22] 
];

// 48-41 bottle thread for 3-5L jugs
function bottle_4841_neck_bore() = 41;
function bottle_4841_neck_dia()  = 45;

