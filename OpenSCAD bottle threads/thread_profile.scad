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
function bottle_pco1881_nut_thread_major()   = 27.8; 
function bottle_pco1881_nut_thread_pitch()   = 2.7;
function bottle_pco1881_nut_thread_height()  = 1.15;
function bottle_pco1881_nut_thread_profile() = [
    [0,0],
    [-bottle_pco1881_nut_thread_height(),0.32],
    [-bottle_pco1881_nut_thread_height(),1.12],
    [0,1.42]
];

// PCO-1881 soda bottle neck thread
function bottle_pco1881_neck_clear_dia()      = 21.74;
function bottle_pco1881_neck_thread_dia()     = 24.94;
function bottle_pco1881_neck_thread_pitch()   = 2.7;
function bottle_pco1881_neck_thread_height()  = 1.15;
function bottle_pco1881_neck_thread_profile() = [
    [0,0],
    [0,1.42],
    [bottle_pco1881_neck_thread_height(),1.22],
	[bottle_pco1881_neck_thread_height(),0.22] 
];


// 38mm 2-start HF cap (BERICAP compatible, 1L Granini bottle)
function bottle_2S38HF_nut_thread_major()   = 37.5;
function bottle_2S38HF_nut_thread_pitch()   = 3.63;
function bottle_2S38HF_nut_thread_height()  = 1.0;
function bottle_2S38HF_nut_thread_profile() = [
	[-bottle_2S38HF_nut_thread_height(),1.0],
    [-bottle_2S38HF_nut_thread_height(),1.5],
    [0,1.9],
    [0,0]
];

// 38mm 2-start HF neck (BERICAP compatible, 1L Granini bottle) 
function bottle_2S38HF_neck_clear_dia()      = 32.5; 
function bottle_2S38HF_neck_thread_minor()   = 35.0; 
function bottle_2S38HF_neck_thread_pitch()   = 3.63;
function bottle_2S38HF_neck_thread_height()  = 1.2;
function bottle_2S38HF_neck_thread_profile() = [
    [0,0],
	[bottle_2S38HF_neck_thread_height(),0.4],
	[bottle_2S38HF_neck_thread_height(),0.9],
	[0,1.9]
];


// 38mm 3-start CF cap (BERICAP 3439 compatible, 5L uncarbonated water)
function bottle_3S38CF_nut_thread_major()   = 38.2;
function bottle_3S38CF_nut_thread_pitch()   = 3.0;
function bottle_3S38CF_nut_thread_height()  = 1.0;
function bottle_3S38CF_nut_thread_profile() = [
	[-bottle_3S38CF_nut_thread_height(),0.8],
    [-bottle_3S38CF_nut_thread_height(),1.2],
    [0,1.6],
    [0,0]
];

// 38mm 3-start HT neck (BERICAP 3439 compatible, 5L uncarbonated water) 
function bottle_3S38CF_neck_clear_dia()      = 33.4; 
function bottle_3S38CF_neck_thread_minor()   = 36.0; 
function bottle_3S38CF_neck_thread_pitch()   = 3.0;
function bottle_3S38CF_neck_thread_height()  = 1.0;
function bottle_3S38CF_neck_thread_profile() = [
    [0,0],
	[bottle_3S38CF_neck_thread_height(),0.4],
	[bottle_3S38CF_neck_thread_height(),0.8],
	[0,1.6]
];


// 48-41 bottle cap thread (estimated from bottle thread dims)
function bottle_4841_nut_thread_major()   = 48;
function bottle_4841_nut_thread_pitch()   = 3.3;
function bottle_4841_nut_thread_height()  = 1.0;
function bottle_4841_nut_thread_profile() = [
	[-bottle_4841_nut_thread_height(),1],
    [-bottle_4841_nut_thread_height(),1.25],
    [0,1.5],
    [0,0]
];

// 48-41 bottle thread for 3-5L jugs
function bottle_4841_neck_clear_dia()      = 41;
function bottle_4841_neck_thread_minor()   = 45;
function bottle_4841_neck_thread_pitch()   = 3.3;
function bottle_4841_neck_thread_height()   = 1.35;
function bottle_4841_neck_thread_profile() = [
    [0,0],
	[bottle_4841_neck_thread_height(),0.4],
	[bottle_4841_neck_thread_height(),0.7],
	[0,1.5]
];

