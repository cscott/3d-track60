/* Swinging draw bridge */

/* [Global] */
part = "all"; // [base,swing]
surface = "road-road"; // [road-road,rail-rail,road-rail,rail-road]

/* [Hidden] */
use <./track60.scad>;
use <../trains/tracklib.scad>;
use <./strutil.scad>

basic_radius = track60_basic_radius();

function dist2(x,y) = pow(x, 2) + pow(y, 2);
function dist(x, y) = sqrt(dist2(x,y));
// XXX add some amount of "extra", maybe 5mm
function swing_radius(radius) = (straight_length(radius) - radius) +
  sqrt(2)*(wood_width()/2);

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
    // XXX don't cut out this cylinder, cut out gantlet arc, so that
    //     swing part can rest on protrusion.
    cylinder(r=swing_radius(radius), h=2*riser_height());
    // XXX cutout dogbone at bottom
  }
  // XXX center support pillar
}

module swing_bridge_swing(radius=basic_radius, surface="rail-rail") {
  clearance = 0.75;
  intersection() {
    translate([0,0,riser_height()])
      shortname60(radius, "AV", swing_surface(surface));
    cylinder(r=swing_radius(radius)-clearance, h=2*riser_height());
  }
  // XXX remove pivot
}
