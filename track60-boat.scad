/* Ferry boat for 60-degree track system. */

/* [Global] */
part = "all"; // [bottom,side-left,side-right,top,end]

/* [Hidden] */
use <./track60.scad>
use <../trains/tracklib.scad>;
use <common/arch.scad>;
basic_radius = 154;
$fn = 120;

function boat_top_height() = riser_height();
function boat_top_length() = 65;
function boat_top_overhang() = 2.5;
function boat_end_height() = wood_height()*2;
function boat_end_overlap() = wood_width()/2;
function boat_end_depth() = 20;
function boat_side_width() = 3;
function boat_width() = wood_width() + 2*(boat_side_width() + 2*boat_side_clearance() + 2);
function boat_clearance() = 1;
function boat_side_clearance() = 0.5;
function boat_side_slot_depth() = wood_height()/2;
function boat_window_diam() = 18;

track60_boat_part(part=part);

module track60_boat_part(radius=basic_radius, part="all") {
  if (part=="all") {
    track60_boat_part(radius, "bottom");
    for (i=[0,180]) rotate([0,0,i])
      track60_boat_part(radius, "end");
    track60_boat_part(radius, "side-left");
    track60_boat_part(radius, "side-right");
    track60_boat_part(radius, "top");
  } else if (part=="bottom") {
    track60_boat_bottom(radius);
  } else if (part=="end") {
    track60_boat_end(radius);
  } else if (part=="side-left") {
    track60_boat_side(radius);
  } else if (part=="side-right") {
    scale([-1,1,1]) track60_boat_part(radius, "side-left");
  } else if (part=="top") {
    track60_boat_top(radius);
  }
}

module track60_boat_top(radius=basic_radius) {
  top_thick = boat_side_slot_depth() + 1;
  difference() {
    translate([0,0,boat_top_height() + top_thick/2])
      cube([boat_width(), boat_top_length(), top_thick], center=true);
    // slots for sides
    for (i=[1,-1]) scale([i,1,1])
      translate([wood_width()/2 + boat_side_clearance() + boat_side_width()/2,
                 0,
                 boat_top_height()])
        cube([boat_side_width() + 2*boat_side_clearance(),
              boat_top_length() - 2*(boat_top_overhang()-boat_clearance()),
              2*(boat_side_slot_depth()+boat_side_clearance())], center=true);
  }
}

module track60_boat_side(radius=basic_radius) {
  total_height = boat_top_height() - wood_height() + 2*boat_side_slot_depth();
  cutoutr = boat_top_height() + boat_side_slot_depth() - boat_end_height();

  window_diam = boat_window_diam();
  side_width = boat_side_width();
  side_length = straight_length(radius)
    - 2*(boat_end_overlap() + boat_clearance());
  bottom = wood_height() - boat_side_slot_depth();
  short_top_length = boat_top_length() - 2*boat_top_overhang();
  cutoutr2 = min(cutoutr, (side_length - short_top_length)/2);
  window_cheat = 2;

  translate([wood_width()/2 + boat_side_clearance(),0,0]) difference() {
    union() {
      translate([0, -side_length/2, bottom])
        cube([side_width, side_length, boat_end_height() - bottom]);
      translate([0, -short_top_length/2, bottom])
        cube([side_width, short_top_length, total_height]);

      translate([0, -short_top_length/2 - cutoutr2, boat_end_height()])
        cube([side_width, short_top_length + 2*cutoutr2, cutoutr2]);
    }
    for(i=[1,-1]) scale([1,i,1]) {
      // Rounded corners
      translate([0,
                 short_top_length/2 + cutoutr2,
                 boat_end_height() + cutoutr2])
        rotate([0,90,0])
        cylinder(r=cutoutr2, h=3*side_width, center=true);
      // Windows
      translate([0,
                 ((short_top_length - 2*window_diam)/3 + window_diam)/2 +
                 window_cheat,
                 boat_end_height() +
                 (boat_top_height() - boat_end_height())/2])
        rotate([0,90,0])
        cylinder(d=window_diam, h=3*side_width, center=true);
    }
  }
}

module track60_boat_bottom_chamfer(radius=basic_radius) {
  for(i=[1,-1]) scale([i,1,1])
    translate([boat_width()/2, 0, 0])
    rotate([0,45,0])
    cube([wood_height()/sqrt(2), straight_length(radius)+2*boat_end_depth(),
          2*wood_height()],
         center=true);
}

module track60_boat_bottom(radius=basic_radius) {
  intersection() {
  difference() {
    translate([0,0,wood_height()/2])
      cube([boat_width(), straight_length(radius), wood_height()], center=true);
    straight60(radius, "rail-blank", "hole");
    straight60(radius, "rail-blank", "connector");
    // chamfer on bottom
    track60_boat_bottom_chamfer(radius);
    // slots for sides
    for (i=[1,-1]) scale([i,1,1])
      translate([wood_width()/2 + boat_side_clearance() + boat_side_width()/2,
                 0, wood_height()])
        cube([boat_side_width() + 2*boat_side_clearance(),
              straight_length(radius) - 2*boat_end_overlap(),
              2*(boat_side_slot_depth() + boat_side_clearance())], center=true);
  }
  union() {
    translate([0,0,wood_height()])
    cube([boat_width(),
          straight_length(radius)-2*boat_end_overlap(),
          3*wood_height()], center=true);
    for (i=[1,-1]) scale([1,i,1]) track60_boat_end_arch(radius);
  }
  }
}

module track60_boat_end_arch(radius=basic_radius) {
  translate([0,-straight_length(radius/2)+boat_end_overlap(),0]) scale([1,-1,1])
    arch2(width=boat_width(), height=boat_end_overlap() + boat_end_depth(),
          thick=2*boat_end_height() + boat_clearance(), ratio=2.5, center=true);
}

module track60_boat_end(radius=basic_radius) {
  intersection() {
    union() {
      translate([0,-straight_length(radius)/2,0])
        scale([1,1,1.2]) rotate([0,0,90]) wood_plug();
      difference() {
        translate([-boat_width()/2,
                   -straight_length(radius)/2 - boat_end_depth(),
                   0])
          cube([boat_width(), boat_end_overlap() + boat_end_depth(), boat_end_height()]);
        cube([boat_width()+2*boat_clearance(),
              straight_length(radius),
              2*wood_height()], center=true);
        track60_boat_bottom_chamfer(radius);
      }
    }
    track60_boat_end_arch(radius);
  }
}
