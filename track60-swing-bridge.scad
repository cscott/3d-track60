/* Swinging draw bridge */

/* [Global] */

// Which part.
part = "base"; // [base,swing]

// What surface to put on the lower and upper levels (respectively)
surface = "rail-road"; // [road-road,rail-rail,road-rail,rail-road]

/* [Hidden] */
use <track60.scad>;
use <trains/tracklib.scad>;
use <common/strutil.scad>

basic_radius = track60_basic_radius();
$fn=120;

function swing_margin() = 8;
function swing_center_gap() = 2.5;
function swing_pivot_radius() = 10;
function swing_radius(radius) = (straight_length(radius) - radius) +
  sqrt(2)*(wood_width()/2) + swing_margin();

function base_surface(surface) = str(split(surface, "-")[0], "-blank");
function swing_surface(surface)= str(split(surface, "-")[1], "-blank");

track60_swing_bridge(part=part, surface=surface);

module track60_swing_bridge(radius=basic_radius, part="all", surface="rail-rail") {
  if (part == "all") {
    track60_swing_bridge(radius, "base", surface);
    track60_swing_bridge(radius, "swing", surface);
  } else if (part == "base") {
    swing_bridge_base(radius, surface);
  } else if (part == "swing") {
    swing_bridge_swing(radius, surface);
  }
}

module swing_bridge_base(radius=basic_radius, surface="rail-rail") {
  // basic gantlet
  shortname60(radius, "ES", base_surface(surface));
  // ends of swing
  difference() {
    union() {
      translate([0,0,riser_height()])
        shortname60(radius, "AV", swing_surface(surface));
      translate([0,0,riser_height()/2]) rotate([0,0,-60])
        cube([wood_width(), straight_length(radius)-1, riser_height()],
          center=true);
    }
    // cut out gantlet arc so swing part can rest of protrusion.
    difference() {
      translate([0,0,wood_height()/2 + wood_well_height()/2])
        cylinder(r=swing_radius(radius), h=2*riser_height());
      for (i=[1,-1]) rotate([0,0,-60]) scale([1,i,1])
        translate([0,-straight_length(radius),0])
        cylinder(r=radius - wood_width()/2 - swing_margin(), h=riser_height());
    }
    for (i=[0,180]) rotate([0,0,i])
      translate([-radius,-straight_length(radius)/2,-1])
        ring(radius, 60, wood_height() + 2, wood_width() - 0.1);
    // cutout dogbone at bottom
    for (i=[1,-1]) rotate([0,0,-60])
      scale([1,i,1]) translate([0,straight_length(radius)/2,0]) intersection() {
      clearance=0.5; epsilon=.05;
      scale([1,1,(wood_height()+bevel()+clearance)/wood_height()])
        rotate([0,0,-90]) wood_cutout();
      translate([-wood_width()/2, -radius, -epsilon])
        cube([wood_width(), 2*radius, wood_height() + clearance + epsilon]);
    }
  }
  // center support pillar
  rotate([0,0,-60]) difference() {
    translate([0,0,riser_height()/2])
      cube([wood_width(), 2*(straight_length(radius) - radius), riser_height()],
         center=true);
    difference() {
    for (i=[1,-1]) scale([1,i,1]) translate([0,-straight_length(radius), 0])
      cylinder(r=radius + wood_width()/2 + swing_center_gap(),
               h=3*riser_height(), center=true);
    translate([0,0,riser_height() - swing_pivot_radius()])
      cylinder(r1=0, r2=swing_pivot_radius(), h=swing_pivot_radius());
    }
  }
  // center pivot
  swing_bridge_pivot(clear=false);
}

module swing_bridge_pivot(clear=false) {
  clearance = 0.75;
  pivot_height = wood_well_height() - (0.2*3) - clearance;
  pivot_r = 5;
  epsilon = 0.01;
  translate([0,0,riser_height() - epsilon])
    cylinder(r1 = pivot_r + (clear?clearance:0),
             r2 = pivot_r + clearance + (clear?clearance:0),
             h = pivot_height + epsilon);
  if (clear)
    translate([0,0,riser_height() + pivot_height - epsilon])
      cylinder(r = pivot_r + 2*clearance, h = clearance + epsilon);
}

module swing_bridge_swing(radius=basic_radius, surface="rail-rail") {
  clearance = 0.75;
  intersection() {
    translate([0,0,riser_height()])
      shortname60(radius, "AV", swing_surface(surface));
    difference() {
      cylinder(r=swing_radius(radius)-clearance, h=2*riser_height());
      swing_bridge_pivot(clear=true);
    }
  }
}
