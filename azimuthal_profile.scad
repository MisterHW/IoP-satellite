use <scad-utils/transformations.scad>    // https://github.com/openscad/scad-utils
use <list-comprehension-demos/skin.scad> // https://github.com/openscad/list-comprehension-demos


// generates an arc or toroidal profile with optional azimuthal dependence
// aligned to a cylindrical surface with matching $fn
module skinned_arc(sections, r=10, angle=360, fn=120)
{
	$fn = fn;
	steps = ceil(fn*angle/360);
	thing = [ for (i=[0:len(sections)-1]) 
                let(phi = angle*i/steps)
                transform(
                    rotation([0, 0, phi - 90])*
                    translation([0, r, 0])*
                    rotation([90,0,0])*
                    rotation([0,90,0]),
                    sections[i]
                    )
		];

	skin(thing, no_endcaps = (angle==360));
}

function sine_ring_sections(angle=360, offset=5, fn=120, h=12, ampl=0.5, n=24) =  
[
	for (i=[0:ceil(fn*angle/360)]) 
    let( phi = angle*i/(ceil(fn*angle/360))) [
		[-offset,h],
		[-1+ampl*sin(n*phi), h],
		[  +ampl*sin(n*phi),h-1],
		[  +ampl*sin(n*phi),1],
		[-1+ampl*sin(n*phi),0],
		[-offset,0]
    ]
]; 
