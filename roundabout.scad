use <trains/tracklib.scad>;

//roundabout(outer_piece=false); // 4/6 inner
//roundabout(num=2, inner_piece=false); // 4 outer
//roundabout(num=3, inner_piece=false); // 6 outer
//roundabout(inner=95, outer_piece=false); // 8 inner
//roundabout(num=4, inner=95, inner_piece=false); // 8 outer
roundabout(); // show both

// inner is "roundabout" diameter.
// outer is the additional length of the
// 'stubs' reaching out from the roundabout
module roundabout(inner=80, outer=53.5, clearance=0.5, num=3, inner_piece=true, outer_piece=true, snap_fit=true) {
  total = inner + outer;
  base_height = 2.5;
  outer_rim = 10;
  base_rim = 10;
  hub_diam = 10;
  hub_ramp = 4;
  strut_width = num < 4 ? wood_width()/3 : wood_width()/4;
  knob_height = 12;
  knob_diam = 6;
  res = 20; // knob resolution
  snap_fit_height = 2;
  if (outer_piece) {
  difference() {
    union() {
      for (i = [0:num-1] ) {
        rotate( [0, 0, i * 180 / num ]) {
          wood_track_centered( total, false );
        }
      }
      cylinder(h=wood_height(), d=inner+outer_rim*2);
    }
    for (i = [0:num-1] ) {
      rotate( [0, 0, i * 180 / num ]) {
        wood_rails_centered( total );
        translate([-total/2,0,0]) wood_cutout();
        translate([total/2,0,0]) rotate([0,0,180]) wood_cutout();
      }
    }
    difference() {
      translate([0,0,base_height]) cylinder(h=wood_height(), d=inner+(clearance*2));
      cylinder(h=wood_height()+base_height*2, d=hub_diam);
      translate([0,0,base_height]) cylinder(h=hub_ramp, d1=hub_diam+hub_ramp*2, d2=hub_diam);
    }
    translate([0,0,-clearance]) difference() {
      cylinder(h=wood_height()+clearance*2, d=inner-base_rim*2);
      translate([0,0,-clearance]) {
        cylinder(h=wood_height()+clearance*4, d=hub_diam+(hub_ramp*2)+base_rim);
        for(i = [0:num-1] ) {
          rotate( [0, 0, i * 180 / num ]) {
            cube(size=[inner,strut_width,2*(wood_height()+clearance*4)], center=true);
          }
        }
      }
    }
  }
  // add an extra "snap fit" widening of central shaft
  if (snap_fit) {
    translate([0,0,wood_height()-snap_fit_height]) cylinder(h=snap_fit_height, d1=hub_diam, d2=hub_diam+clearance*2);
  }
  }
  if (inner_piece) {
    translate([0,0,outer_piece ? 0 : -base_height+clearance]) {
      difference() {
        translate([0,0,base_height+clearance]) cylinder(h=wood_height()-(base_height+clearance), d=inner);
        cylinder(h=wood_height()+clearance, d=hub_diam+clearance*2);
        translate([0,0,base_height]) cylinder(h=hub_ramp, d1=hub_diam+hub_ramp*2+clearance*2, d2=hub_diam+clearance*2);
        wood_rails_centered(inner);
        if (snap_fit) {
          translate([0,0,wood_height()-snap_fit_height]) {
            cylinder(h=snap_fit_height, d1=hub_diam+clearance*2, d2=hub_diam+clearance*4);
            translate([0,0,snap_fit_height]) cylinder(h=1, d=hub_diam+clearance*4);
          }
        }
      }
      // now add knob
      translate([0,inner/2 - knob_diam,wood_height()-clearance]) {
        cylinder(h=knob_height+clearance,d=knob_diam,$fn=res);
        cylinder(h=knob_diam,d1=knob_diam*2, d2=knob_diam, $fn=res);
        translate([0,0,knob_height+clearance]) sphere(d=knob_diam, $fn=res);
      }
    }
  }
}
module wood_track_centered(length=53.5, rails=true) {
  translate([-length/2,-wood_width()/2,0]) {
    wood_track(length, rails);
  }
}
module wood_rails_centered(length=53.5, bevel_ends=true) {
  translate([-length/2,-wood_width()/2,0]) {
    wood_rails(length, bevel_ends);
  }
}
