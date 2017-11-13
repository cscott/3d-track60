/* Swinging draw bridge */

/* [Global] */

// Which part.
part = "base"; // [base,swing]

// What surface to put on the lower and upper levels (respectively)
surface = "rail-road"; // [road-road,rail-rail,road-rail,rail-road]

// What style (gantlet or straight crossing)
style = "ES"; // [ES, AT]

/* [Hidden] */
use <track60.scad>;
use <trains/tracklib.scad>;
use <common/arch.scad>
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
function flip_surface(surface) = str(split(surface, "-")[1], "-", split(surface, "-")[0]);

track60_swing_bridge(part=part, surface=surface, style=style);

module track60_swing_bridge(radius=basic_radius, part="all", surface="rail-rail", style="ES") {
  if (part == "all") {
    track60_swing_bridge(radius, "base", surface, style);
    track60_swing_bridge(radius, "swing", surface, style);
  } else if (part == "base") {
    swing_bridge_base(radius, surface, style);
  } else if (part == "swing") {
    swing_bridge_swing(radius, surface);
  }
}

module swing_bridge_base(radius=basic_radius, surface="rail-rail", style="ES") {
  type_is_gantlet = (style == "ES");
  // basic gantlet
  if (type_is_gantlet) {
    shortname60(radius, "ES", base_surface(surface));
  } else {
    bsurface = base_surface(surface);
    if (bsurface == "road-blank") {
      shortname60(radius, "at", bsurface);
    } else {
      translate([0,0,wood_height()/2]) rotate([0,180,0]) translate([0,0,-wood_height()/2])
        shortname60(radius, "av", flip_surface(bsurface));
    }
  }
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
    if (type_is_gantlet) {
      difference() {
        translate([0,0,wood_height()/2 + wood_well_height()/2])
          cylinder(r=swing_radius(radius), h=2*riser_height());
        for (i=[1,-1]) rotate([0,0,-60]) scale([1,i,1])
          translate([0,-straight_length(radius),0])
          cylinder(r=radius - wood_width()/2 - swing_margin(),
                   h=riser_height());
      }
    } else {
      translate([0,0,riser_height()])
        cylinder(r=swing_radius(radius), h=riser_height());
       rotate([0,0,60])
         translate([0,0,wood_height()/2 + wood_well_height()/2])
         rotate([90,0,0])
         arch2(2*wood_width() + double_gutter() + 2*swing_margin(),
               1.5*riser_height(), 2*radius, center=true);
    }
    // clear roadway
    if (type_is_gantlet) {
      for (i=[0,180]) rotate([0,0,i])
        translate([-radius,-straight_length(radius)/2,-1])
          ring(radius, 60, wood_height() + 2, wood_width() - 0.1);
    } else {
      rotate([0,0,60])
        cube([2*wood_width() + double_gutter() - 0.1,
              2*radius, 2*wood_height() + 2], center=true);
    }
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
  rotate([0,0,type_is_gantlet ? -60 : -30]) difference() {
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
  // extra support for raised track
  ledge = 2*wood_plug_radius();
  ledge_thick = 2; // thickness before arch cutout starts
  for (i=[0,180]) rotate([0,0,-60 + i]) difference() {
    epsilon = 0.05;
    translate([-wood_width()/2, straight_length(radius)/2 - epsilon, wood_height()])
      cube([wood_width(), ledge + epsilon, riser_height() - wood_height()]);
    translate([0, straight_length(radius)/2 + ledge, 0])
      rotate([90,0,90])
        arch2(2*ledge + 3*epsilon, riser_height() - ledge_thick,
              wood_width() + epsilon, center=true);
  }
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
