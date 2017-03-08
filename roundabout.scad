/* Roundabout for brio-compatible trains */

/* [Global] */

// This design is composed of a number of separate printable parts:
part = "6_assembled"; // [4_assembled:Four-way roundabout (assembly),4_inner:Four-way roundabout (inner piece),4_outer:Four-way roundabout (outer piece),6_assembled:Six-way roundabout (assembly),6_inner:Six-way roundabout (inner piece),6_outer:Six-way roundabout (outer piece),8_assembled:Eight-way roundabout (assembly),8_inner:Eight-way roundabout (inner piece),8_outer:Eight-way roundabout (outer piece)]

/* [Hidden] */
use <../trains/tracklib.scad>;

roundabout_demo(part);

// Sample instantiations
module roundabout_demo(part="6_assembled", size="medium") {
  if (part=="4_assembled") {
    roundabout(num=2, which="both", size=size); // show both inner and outer for a 4-way roundabout
  } else if (part=="4_inner") {
    roundabout(num=2, which="inner", size=size); // inner for 4-way
  } else if (part=="4_outer") {
    roundabout(num=2, which="outer", size=size); // 4-way outer piece
  } else if (part=="6_assembled") {
    roundabout(num=3, which="both", size=size); // show both inner and outer for a 6-way roundabout
  } else if (part=="6_inner") {
    roundabout(num=3, which="inner", size=size); // inner for 6-way
  } else if (part=="6_outer") {
    roundabout(num=3, which="outer", size=size); // 6-way outer piece
  } else if (part=="8_assembled") {
    roundabout(num=4, which="both", size=size); // show both inner and outer for 8-way
  } else if (part=="8_inner") {
    roundabout(num=4, which="inner", size=size); // 8-way inner piece
  } else if (part=="8_outer") {
    roundabout(num=4, which="outer", size=size); // 8-way outer piece
  }
}

// "small" size can only be used for 4 or 6 way.
// "medium" is the largest that can fit on a 6"x6" printer.
module roundabout(size="medium", num=3, which="both") {
  inner_piece = (which=="inner") || (which=="both");
  outer_piece = (which=="outer") || (which=="both");
  if (size=="small") {
    roundabout_custom(inner=80, outer=53.5,
                      num=num, inner_piece=inner_piece, outer_piece=outer_piece);
  } else if (size=="large") {
    roundabout_custom(inner=152, outer=53.5,
                      num=num, inner_piece=inner_piece, outer_piece=outer_piece);
  } else { // "medium" size
    roundabout_custom(inner=95, outer=46,
                      num=num, inner_piece=inner_piece, outer_piece=outer_piece);
  }
}

// inner is "roundabout" diameter.
// outer is the additional length of the
// 'stubs' reaching out from the roundabout
module roundabout_custom(inner=95, outer=46, clearance=1, num=3, snap_fit=true,
                  inner_piece=true, outer_piece=true, rails=true,
                  hub_height=wood_height(), inner_num=1) {
  // Dimensions
  total = inner + outer;
  base_height = 2.5;
  outer_rim = 10;
  base_rim = 8;
  snap_fit_height = 2;
  hub_diam = 10;
  hub_ramp = min(4, max(0,
                 hub_height - base_height - (snap_fit?snap_fit_height:0) - 1));
  strut_width = num < 4 ? wood_width()/3 : wood_width()/4;
  guard_height = 5;
  guard_width = 2;
  knob_height = 14;
  knob_diam = 6;
  res = 120; // rotating pieces resolution
  knob_res = 25; // knob resolution

  // Outer piece
  if (outer_piece) {
    difference() {
      // Start with `num` tracks and a cylinder around them, then
      // carve away stuff.
      union() {
        for ( i = [0:num-1] ) {
          rotate( [0, 0, i * 180 / num ]) {
            wood_track_centered( total, rails=false );
          }
        }
        cylinder(h=wood_height(), d=inner + outer_rim*2);
      }
      // Carve away the rails, and female connectors
      for ( i = [0:num-1] ) {
        rotate( [0, 0, i * 180 / num ]) {
          if (rails) wood_rails_centered( total );
          translate([-total/2,0,0])
            wood_cutout();
          translate([total/2,0,0]) rotate([0,0,180])
            wood_cutout();
        }
      }
      // Carve away the central cutout (less the hub)
      difference() {
        union() {
          translate([0, 0, base_height + clearance])
            cylinder(h=wood_height(), d=inner + (clearance*2), $fn=res);
          translate([0, 0, base_height])
            cylinder(h=wood_height(), d=inner - (base_rim*2), $fn=res);
        }
        translate([0,0,-base_height])
          cylinder(h=hub_height + base_height, d=hub_diam, $fn=res);
        translate([0,0,base_height])
          cylinder(h=hub_ramp, d1=hub_diam + hub_ramp*2, d2=hub_diam, $fn=res);
      }
      // Carve away the openings to the ground
      // formed by adding back `cube` shaped struts.
      translate([0,0,-clearance]) difference() {
        // central cutout minus the base rim
        cylinder(h=wood_height() + clearance*2,
                 d=inner - base_rim*2, $fn=res);
        translate([0, 0, -clearance]) {
          // minus the hub (and a base_rim sized rim around it)
          cylinder(h=( wood_height() + clearance*4 ),
                   d=( hub_diam + (hub_ramp*2) + base_rim) );
          // struts at each of the track locations
          for ( i = [0:num-1] ) {
            rotate( [0, 0, i * 180 / num ]) {
              cube(size=[inner, strut_width, 2*(wood_height() + clearance*4)],
                   center=true);
            }
          }
        }
      }
    }
    // add an extra "snap fit" widening of central shaft
    if ( snap_fit ) {
      translate([0, 0, hub_height - snap_fit_height])
        cylinder(h=snap_fit_height, d1=hub_diam, d2=hub_diam + clearance*2,
                 $fn=res);
    }
    // Detents
    roundabout_detents(num=num, base_height=base_height, base_rim=base_rim,
                       inner=inner, clearance=clearance, res=res,
                       inner_piece=false);
  }

  // Inner rotating piece
  if (inner_piece) {
    // Put this piece flat on the xy plane if we're rendering it by itself.
    translate([0, 0, outer_piece||!rails ? 0 : -(base_height + clearance)]) {
      // Main cylinder body, minus rails and hub clearances
      difference() {
        // Main body
        translate([0, 0, base_height + clearance])
          cylinder(h=wood_height() - (base_height + clearance),
                   d=inner, $fn=res);
        // Rails down the center
        if (rails) wood_rails_centered(inner);
        // Central hub
        cylinder(h=hub_height + clearance,
                 d=hub_diam + clearance*2, $fn=res);
        // Hub ramp (start low @ base_height to ensure we punch through)
        translate([0, 0, base_height])
          cylinder(h=hub_ramp + clearance*sqrt(2),
                   d1=hub_diam + hub_ramp*2 + clearance*sqrt(2)*2,
                   d2=hub_diam, $fn=res);
        // Snap fit hub (add extra clearance/10 height to ensure we punch thru)
        if (snap_fit) {
          translate([0, 0, hub_height - snap_fit_height]) {
            cylinder(h=snap_fit_height,
                     d1=hub_diam + clearance*2,
                     d2=hub_diam + clearance*4, $fn=res);
            translate([0,0,snap_fit_height-clearance/10])
              cylinder(h=clearance+clearance/10,
                       d=hub_diam + clearance*4, $fn=res);
          }
        }
        // Detents
        roundabout_detents(num=num, base_height=base_height, base_rim=base_rim,
                           inner=inner, clearance=clearance, res=res,
                           inner_piece=true);
      }
      // add a bit of "guard rail"
      translate([0, 0, wood_height() - clearance]) {
        difference() {
          translate([0, 0, clearance/2]) // just ensure we sink into top
            cylinder(h=guard_height + clearance/2, d=inner, $fn=res);
          cylinder(h=guard_height + clearance*2, d=inner - guard_width*2, $fn=res);
          // protect the track
          for ( i = [0:1:inner_num-1] ) rotate( [0, 0, i * 180 / num ])
            cube([inner + clearance,
                  wood_width() + clearance*2,
                  2*(guard_height + clearance*2)], center=true);
        }
      }
      // now add knob
      translate([0, inner/2 - knob_diam, wood_height() - clearance]) {
        // shaft
        cylinder(h=knob_height + clearance, d=knob_diam, $fn=knob_res);
        cylinder(h=guard_height + clearance, d=knob_diam*2, $fn=knob_res);
        // ramp
        translate([0, 0, guard_height+clearance])
          cylinder(h=knob_diam/2, d1=knob_diam*2, d2=knob_diam, $fn=knob_res);
        // round top
        translate([0, 0, knob_height + clearance])
          sphere(d=knob_diam, $fn=knob_res);
      }
    }
  }
}

// Helper: detents
module roundabout_detents(num, base_height, base_rim, inner, clearance, res, inner_piece) {
  detent_extra_radius = 25;
  detent_height = clearance;
  extra = inner_piece ? 2*clearance : 0;
  translate([0,0,base_height+clearance - detent_extra_radius])
  difference() {
    for ( i = [0:num-1] ) {
      rotate( [0, 0, i * 180 / num ] )
        rotate([0,90,0])
        cylinder(d=2*(detent_height + detent_extra_radius) + extra, h=inner + 2*clearance + 1, center=true, $fn=res);
    }
    cylinder(h=2*(detent_height + detent_extra_radius) + extra + 1, d=inner - (base_rim*2) - extra, center=true, $fn=res);

    cube_height=2*(detent_height + detent_extra_radius) + extra + 2;
    translate([0,0,-cube_height/2 + detent_extra_radius - .1])
      cube([inner + cube_height + 2*clearance + 2,
            inner + cube_height + 2*clearance + 2,
            cube_height],
           center=true);
  }
}

// Helper function: center the wood_track() on the origin.
module wood_track_centered(length=53.5, rails=true) {
  translate([-length/2, -wood_width()/2, 0]) {
    wood_track(length, rails);
  }
}

// Helper function: center the wood_rails() on the origin.
module wood_rails_centered(length=53.5, bevel_ends=true) {
  translate([-length/2, -wood_width()/2, 0]) {
    wood_rails(length, bevel_ends);
  }
}
