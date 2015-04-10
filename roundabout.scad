/* Roundabout for brio-compatible trains */

/* [Global] */

// This design is composed of a number of separate printable parts:
part = "6_assembled"; // [4_assembled:Four-way roundabout (assembly),4_inner:Four-way roundabout (inner piece),4_outer:Four-way roundabout (outer piece),6_assembled:Six-way roundabout (assembly),6_inner:Six-way roundabout (inner piece),6_outer:Six-way roundabout (outer piece),8_assembled:Eight-way roundabout (assembly),8_inner:Eight-way roundabout (inner piece),8_outer:Eight-way roundabout (outer piece)]

/* [Hidden] */
use <../trains/tracklib.scad>;

demo(part);

// Sample instantiations
module demo(part="6_assembled") {
  if (part=="4_assembled") {
    roundabout(num=2); // show both inner and outer for a 4-way roundabout
  } else if (part=="6_assembled") {
    roundabout(num=3); // show both inner and outer for a 6-way roundabout
  } else if (part=="4_inner") {
    roundabout(num=2,outer_piece=false); // inner for 4-way
  } else if (part=="4_outer") {
    roundabout(num=2, inner_piece=false); // 4-way outer piece
  } else if (part=="6_inner") {
    roundabout(num=3,outer_piece=false); // inner for 6-way
  } else if (part=="6_outer") {
    roundabout(num=3, inner_piece=false); // 6-way outer piece
  } else if (part=="8_assembled") {
    roundabout(num=4, inner=95, outer=46); // show both inner and outer for 8-way
  } else if (part=="8_inner") {
    roundabout(num=4, inner=95, outer=46, outer_piece=false); // 8-way inner piece
  } else if (part=="8_outer") {
    roundabout(num=4, inner=95, outer=46, inner_piece=false); // 8-way outer piece
  }
}

// inner is "roundabout" diameter.
// outer is the additional length of the
// 'stubs' reaching out from the roundabout
module roundabout(inner=80, outer=53.5, clearance=1, num=3, snap_fit=true,
                  inner_piece=true, outer_piece=true) {
  // Dimensions
  total = inner + outer;
  base_height = 2.5;
  outer_rim = 10;
  base_rim = 8;
  hub_diam = 10;
  hub_ramp = 4;
  strut_width = num < 4 ? wood_width()/3 : wood_width()/4;
  guard_height = 5;
  guard_width = 2;
  knob_height = 14;
  knob_diam = 6;
  res = 120; // rotating pieces resolution
  knob_res = 25; // knob resolution
  snap_fit_height = 2;

  // Outer piece
  if (outer_piece) {
    difference() {
      // Start with `num` tracks and a cylinder around them, then
      // carve away stuff.
      union() {
        for ( i = [0:num-1] ) {
          rotate( [0, 0, i * 180 / num ]) {
            wood_track_centered( total, false );
          }
        }
        cylinder(h=wood_height(), d=inner + outer_rim*2);
      }
      // Carve away the rails, and female connectors
      for ( i = [0:num-1] ) {
        rotate( [0, 0, i * 180 / num ]) {
          wood_rails_centered( total );
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
        cylinder(h=wood_height() + base_height*2, d=hub_diam, $fn=res);
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
      translate([0, 0, wood_height() - snap_fit_height])
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
    translate([0, 0, outer_piece ? 0 : -(base_height + clearance)]) {
      // Main cylinder body, minus rails and hub clearances
      difference() {
        // Main body
        translate([0, 0, base_height + clearance])
          cylinder(h=wood_height() - (base_height + clearance),
                   d=inner, $fn=res);
        // Rails down the center
        wood_rails_centered(inner);
        // Central hub
        cylinder(h=wood_height() + clearance,
                 d=hub_diam + clearance*2, $fn=res);
        // Hub ramp (add extra clearance/10 height to ensure we punch through)
        translate([0, 0, base_height + clearance - clearance/10])
          cylinder(h=hub_ramp + clearance/10,
                   d1=hub_diam + hub_ramp*2 + clearance*2,
                   d2=hub_diam + clearance*2, $fn=res);
        // Snap fit hub (add extra clearance/10 height to ensure we punch thru)
        if (snap_fit) {
          translate([0, 0, wood_height() - snap_fit_height]) {
            cylinder(h=snap_fit_height + clearance/10,
                     d1=hub_diam + clearance*2,
                     d2=hub_diam + clearance*4, $fn=res);
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
          cube([inner + clearance, wood_width() + clearance*2, 2*(guard_height + clearance*2)],
               center=true);
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
  detent_height = clearance;
  extra = inner_piece ? 2*clearance : 0;
  translate([0,0,base_height+clearance])
  difference() {
    for ( i = [0:num-1] ) {
      rotate( [0, 0, i * 180 / num ] )
        rotate([0,90,0])
        cylinder(d=2*detent_height + extra, h=inner + 2*clearance + 1, center=true, $fn=30);
    }
    cylinder(h=2*detent_height + extra + 1, d=inner - (base_rim*2) - extra, center=true, $fn=res);
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
