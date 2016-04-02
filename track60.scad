/* Dave Barber's 60-degree brio track system */

/* [Global] */
part = "slope"; // [curve:Basic 60 degree curve,straight:Straight,half_straight:Special half-length straight,half_dbl_straight:Special half-length double straight,crossing1:Crossing #1,crossing2:Crossing #2,crossing3:Crossing #3,crossing4:Crossing #4,crossing5:Crossing #5,crossing6:Crossing #6 (double xover),crossing7-left:Crossing #7 (double to single; one left one straight),crossing7-right:Crossing #7 (double to single; one right one straight),crossing7-rail:Crossing #7 alternate (rails),crossing7-road:Crossing #7 alternate (road),crossing8-left:Crossing #8 (double to single xover; one left one straight),crossing8-right:Crossing #8 (double to single xover; one right one straight),crossing8-rail:Crossing #8 alternate (rails),crossing8-road:Crossing #8 alternate (road),crossing9:Crossing #9 (double to single; one left one right),crossing10:Crossing #10 (double to single xover; one left one right),switch1-left:Switch #1 (left hand),switch1-right:Switch #1 (right hand),switch1-rail:Switch #1 alternate (rails),switch1-road:Switch #1 alternate (road),switch2:Switch #2,switch3-left:Switch #3 (left hand),switch3-right:Switch #3 (right hand),switch3-rail:Switch #3 alternate (rails),switch3-road:Switch #3 alternate (road),switch4:Switch #4,switch5:Switch #5,switch6:Switch #6 (single to double),switch7-left:Switch #7 (left hand curved double to straight single wye),switch7-right:Switch #7 (right hand curved double to straight single wye),switch7-rail:Switch #7 alternate (rails),switch7-road:Switch #7 alternate (road),switch8-left:Switch #8 (left hand curved double to xover straight single wye),switch8-right:Switch #8 (right hand curved double to xover straight single wye),switch8-rail:Switch #8 alternate (rails),switch8-road:Switch #8 alternate (road),switch9-left:Switch #9 (straight double to left curved single wye),switch9-right:Switch #9 (straight double to right curved single wye),switch9-rail:Switch #9 alternate (rails),switch9-road:Switch #9 alternate (road),switch10-left:Switch #10 (straight double to xover left curved single wye),switch10-right:Switch #10 (straight double to xover right curved single wye),switch10-rail:Switch #10 alternate (rails),switch10-road:Switch #10 alternate (road),switch11-left:Switch #11 (left hand curved double to right hand curved single wye),switch11-right:Switch #11 (right hand curved double to left hand curved single wye),switch11-rail:Switch #11 alternate (rails),switch11-road:Switch #11 alternate (road),switch12-left:Switch #12 (left hand curved double to xover right hand curved single wye),switch12-right:Switch #12 (right hand curved double to xover left hand curved single wye),switch12-rail:Switch #12 alternate (rails),switch12-road:Switch #12 alternate (road),switch13-left:Switch #13 (double straight left xover),switch13-right:Switch #13 (double straight right xover),switch13-rail:Switch #13 alternate (rails),switch13-road:Switch #13 alternate (road),switch14-left:Switch #14 (left hand curved double to single),switch14-right:Switch #14 (right hand curved double to single),switch14-rail:Switch #14 alternate (rails),switch14-road:Switch #14 alternate (road),switch15-left:Switch #15 (single-to-double left curved switch with right single curve),switch15-right:Switch #15 (single-to-double right curved switch with left single curve),switch15-rail:Switch #15 alternate (rails),switch15-road:Switch #15 alternate (road),switch16-left:Switch #16 (single-to-double left curved switch with right xover single curve),switch16-right:Switch #16 (single-to-double right curved switch with left xover single curve),switch16-rail:Switch #16 alternate (rails),switch16-road:Switch #16 alternate (road),misc1:Mixed switch and crossing #1,misc2:Mixed switch and crossing #2,misc3:Mixed switch and crossing #3,misc4:Mixed switch and crossing #4,roundabout:Roundabout (assembled),roundabout-inner:Roundabout (inner piece),roundabout-outer:Roundabout (outer piece),dogbone:Male-male connector,dbl_straight:Double-track straight,dbl_curve:Double-track curve,building:Building connector]

/* [Hidden] */
use <../dotscad/pie.scad>;
use <../trains/tracklib.scad>;
use <../trains/track-wooden/dog-bone.scad>;
use <../trains/track-wooden/track-standard.scad>;
use <./roundabout.scad>

// Dave suggests a base radius of 200mm.
// The core hexagon will then have a diameter of
// (4/3)r, or 266.7mm, and a "flat side height"
// of 2r/sqrt(3), or 230.9mm.
//basic_radius = 200;
// We want to fit the core hexagon in a build
// area of 200mm square, so we suggested the following
// basic radius:
//basic_radius = 170;
// However, our wTrak-like system works nicely
// if 7 hex cells (flat-to-flat) are 49 inches, hence:
basic_radius = 154;

function straight_length(radius) = 2*radius/sqrt(3);

/* Option 1: */
function tie_spacing(radius) = radius*((1/sqrt(3))-(PI/6))*2/*to taste*/;
function tie_angle(radius) = 180 * tie_spacing(radius) / (PI * radius);
/* */

/* Option 2:
function tie_angle(radius) = 6;
function tie_spacing(radius) = (tie_angle(radius) * PI * radius) / 180;
/* */

function tie_height()=(wood_height()-wood_well_height())/2;
function tie_width()=2;
function well_tie_height()=1;

// In tracklib:
//  wood_well_spacing should be 19.15
//  wood_well_width() = (31.3 - wood_well_spacing())/2 = 6.075 ~= 6.1

function road_height() = (wood_height()-2);
function road_width() = wood_well_spacing() + 2*wood_well_width();

function stripe_width() = 2;
function stripe_height() = 1;

// gutter between double-track pieces.
function double_gutter() = 10;

function other_dir(dir) = (dir=="left")?"right":"left";

// Make curves look nice.
$fn = 120;

track60_demo(part);

// Sample instantiations
module track60_demo(part="curve_rail",r=basic_radius) {
  hex_edge = 2*r/3;

  if (part=="curve") {
    curve60_left(r, road=true, rail=true);
  } else if (part=="straight") {
    straight60(r, road=true, rail=true);
  } else if (part=="half_straight") {
    half_straight60(r, road=true, rail=true);
  } else if (part=="crossing1") {
    crossing60(r, 1, rail=true, road=true);
  } else if (part=="crossing2") {
    crossing60(r, 2, rail=true, road=true);
  } else if (part=="crossing3") {
    crossing60(r, 3, rail=true, road=true);
  } else if (part=="crossing4") {
    crossing60(r, 4, rail=true, road=true);
  } else if (part=="crossing5") {
    crossing60(r, 5, rail=true, road=true);
  } else if (part=="crossing6") {
    crossing60(r, 6, rail=true, road=true);
  } else if (part=="crossing7-left") {
    crossing60(r, 7, "left", rail=true, road=true);
  } else if (part=="crossing7-right") {
    crossing60(r, 7, "right", rail=true, road=true);
  } else if (part=="crossing7-road") {
    crossing60(r, 7, road=true); // Left on top, right on bottom.
  } else if (part=="crossing7-rail") {
    crossing60(r, 7, rail=true); // Left on top, right on bottom.
  } else if (part=="crossing8-left") {
    crossing60(r, 8, "left", rail=true, road=true);
  } else if (part=="crossing8-right") {
    crossing60(r, 8, "right", rail=true, road=true);
  } else if (part=="crossing8-road") {
    crossing60(r, 8, road=true); // Left on top, right on bottom.
  } else if (part=="crossing8-rail") {
    crossing60(r, 8, rail=true); // Left on top, right on bottom.
  } else if (part=="crossing9") {
    crossing60(r, 9, rail=true, road=true);
  } else if (part=="crossing10") {
    crossing60(r, 10, rail=true, road=true);
  } else if (part=="switch1-left") {
    switch60(r, 1, "left", rail=true, road=true);
  } else if (part=="switch1-right") {
    switch60(r, 1, "right", rail=true, road=true);
  } else if (part=="switch1-rail") {
    // Rails on both sides, can flip to make left or right
    switch60(r, 1, rail=true);
  } else if (part=="switch1-road") {
    // Roads on both sides, can flip to make left or right
    switch60(r, 1, road=true);
  } else if (part=="switch2") {
    switch60(r, 2, rail=true, road=true);
  } else if (part=="switch3-left") {
    switch60(r, 3, "left", rail=true, road=true);
  } else if (part=="switch3-right") {
    switch60(r, 3, "right", rail=true, road=true);
  } else if (part=="switch3-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 3, rail=true);
  } else if (part=="switch3-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 3, road=true);
  } else if (part=="switch4") {
    switch60(r, 4, rail=true, road=true);
  } else if (part=="switch5") {
    switch60(r, 5, rail=true, road=true);
  } else if (part=="switch6") {
    switch60(r, 6, rail=true, road=true);
  } else if (part=="switch7-left") {
    switch60(r, 7, "left", rail=true, road=true);
  } else if (part=="switch7-right") {
    switch60(r, 7, "right", rail=true, road=true);
  } else if (part=="switch7-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 7, rail=true);
  } else if (part=="switch7-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 7, road=true);
  } else if (part=="switch8-left") {
    switch60(r, 8, "left", rail=true, road=true);
  } else if (part=="switch8-right") {
    switch60(r, 8, "right", rail=true, road=true);
  } else if (part=="switch8-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 8, rail=true);
  } else if (part=="switch8-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 8, road=true);
  } else if (part=="switch9-left") {
    switch60(r, 9, "left", rail=true, road=true);
  } else if (part=="switch9-right") {
    switch60(r, 9, "right", rail=true, road=true);
  } else if (part=="switch9-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 9, rail=true);
  } else if (part=="switch9-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 9, road=true);
  } else if (part=="switch10-left") {
    switch60(r, 10, "left", rail=true, road=true);
  } else if (part=="switch10-right") {
    switch60(r, 10, "right", rail=true, road=true);
  } else if (part=="switch10-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 10, rail=true);
  } else if (part=="switch10-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 10, road=true);
  } else if (part=="switch11-left") {
    switch60(r, 11, "left", rail=true, road=true);
  } else if (part=="switch11-right") {
    switch60(r, 11, "right", rail=true, road=true);
  } else if (part=="switch11-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 11, rail=true);
  } else if (part=="switch11-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 11, road=true);
  } else if (part=="switch12-left") {
    switch60(r, 12, "left", rail=true, road=true);
  } else if (part=="switch12-right") {
    switch60(r, 12, "right", rail=true, road=true);
  } else if (part=="switch12-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 12, rail=true);
  } else if (part=="switch12-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 12, road=true);
  } else if (part=="switch13-left") {
    switch60(r, 13, "left", rail=true, road=true);
  } else if (part=="switch13-right") {
    switch60(r, 13, "right", rail=true, road=true);
  } else if (part=="switch13-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 13, rail=true);
  } else if (part=="switch13-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 13, road=true);
  } else if (part=="switch14-left") {
    switch60(r, 14, "left", rail=true, road=true);
  } else if (part=="switch14-right") {
    switch60(r, 14, "right", rail=true, road=true);
  } else if (part=="switch14-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 14, rail=true);
  } else if (part=="switch14-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 14, road=true);
  } else if (part=="switch15-left") {
    switch60(r, 15, "left", rail=true, road=true);
  } else if (part=="switch15-right") {
    switch60(r, 15, "right", rail=true, road=true);
  } else if (part=="switch15-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 15, rail=true);
  } else if (part=="switch15-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 15, road=true);
  } else if (part=="switch16-left") {
    switch60(r, 16, "left", rail=true, road=true);
  } else if (part=="switch16-right") {
    switch60(r, 16, "right", rail=true, road=true);
  } else if (part=="switch16-rail") {
    // Rails on both sides, can flip to make left or right switch
    switch60(r, 16, rail=true);
  } else if (part=="switch16-road") {
    // Roads on both sides, can flip to make left or right switch
    switch60(r, 16, road=true);
  } else if (part=="misc1") {
    misc60(r, 1, rail=true, road=true);
  } else if (part=="misc2") {
    misc60(r, 2, rail=true, road=true);
  } else if (part=="misc3") {
    misc60(r, 3, rail=true, road=true);
  } else if (part=="misc4") {
    misc60(r, 4, rail=true, road=true);
  } else if (part=="roundabout") {
    track60_demo(part="roundabout-inner",r=r);
    track60_demo(part="roundabout-outer",r=r);
  } else if (part=="roundabout-inner"||part=="roundabout-outer") {
      ring=45; // just enough for a female connector
      difference() {
        rotate([0,0,90])
        roundabout_custom(outer=ring, inner=straight_length(r)-ring, num=3, rails=false,
          inner_piece=(part!="roundabout-outer"),
          outer_piece=(part!="roundabout-inner"));
        // Add our own rails
        difference() {
          for (p=["hole","ties"]) {
            if (part=="roundabout-inner") {
              intersection() {
                straight60(radius=r, rail=true, part=p);
                if (p=="ties")
                  cylinder(d=straight_length(r)-ring-10,h=wood_height()*3,center=true);
              }
            } else if (part=="roundabout-outer") {
              difference() {
                crossing60(radius=r, which=5, rail=true, part=p);
                if (p=="ties")
                  cylinder(d=straight_length(r)-ring+10,h=wood_height()*3,center=true);
              }
            }
          }
          cube([2*r,2*r,wood_height()], center=true);
        }
      }
  } else if (part=="dogbone") {
    // scale to account for roadway depth
    scale([1,1,road_height()/wood_height()]) dogbone(true);
  } else if (part=="dbl_straight") {
    dbl_straight60(r, road=true, rail=true);
  } else if (part=="dbl_curve") {
    dbl_curve60_left(r, road=true, rail=true);
  } else if (part=="half_dbl_straight") {
    half_dbl_straight60(r, road=true, rail=true);
  } else if (part=="building") {
    building60(r, road=true, rail=true);
  } else if (part=="slope") {
    slope60(r, road=true, rail=true);
  }
}

module union_or_intersection(is_intersection=false) {
  if (is_intersection) {
    for(i=[0:1:$children-2]) {
      for(j=[i+1:1:$children-1]) {
        intersection() { children(i); children(j); }
      }
    }
  } else {
    union() children();
  }
}
module bogus60(radius) {
  // something guaranteed to have an empty intersection with the core hex
  translate([10*radius,10*radius,10*wood_height()]) cube([.1,.1,.1]);
}

// module gantlet(...)?

// Most crossings are mirror symmetric, but the `dir` parameter is used for
// those which aren't.
module crossing60(radius, which, dir="left", rail=false, road=false, part="all",
                  gutter=true, is_intersection=false) {
  if (part=="all") {
    difference() {
      crossing60(radius, which, dir, rail, road, "body", gutter);
      crossing60(radius, which, dir, rail, road, "hole");
      crossing60(radius, which, dir, rail, road, "connector");
      if (rail) difference() {
        crossing60(radius, which, dir, rail, road, "ties");
        crossing60(radius, which, dir, rail, road, "body",
                   gutter=false, is_intersection=true);
      }
    }
  } else if (which==1) {
    union_or_intersection(is_intersection=is_intersection) {
      curve60_right(radius, rail, road, part);
      rotate([0,0,60]) curve60_right(radius, rail, road, part);
    }
  } else if (which==2 || which==4) {
    union_or_intersection(is_intersection=is_intersection) {
      straight60(radius, rail, road, part);
      rotate([0,0,60]) curve60_left(radius, rail, road, part);
      if (which==4) {
        rotate([0,0,-120]) curve60_left(radius, rail, road, part);
      } else if (is_intersection) bogus60(radius);
    }
  } else if (which==3 || which==5) {
    union_or_intersection(is_intersection=is_intersection) {
      straight60(radius, rail, road, part);
      rotate([0,0,60]) straight60(radius, rail, road, part);
      if (which==5) {
        rotate([0,0,-60]) straight60(radius, rail, road, part);
      } else if (is_intersection) bogus60(radius);
    }
  } else if (which==6) {
    // double crossover
    union_or_intersection(is_intersection=is_intersection) {
      dbl_sway60_left(radius, rail, road, part, sway_far=true, gutter=gutter);
      dbl_sway60_right(radius, rail, road, part, sway_far=true, gutter=gutter);
    }
  } else if (which==7 || which==8) {
    // double-to-single crossover (crossing #7 is technically a gantlet)
    // one straight, one curved.
    union_or_intersection(is_intersection=is_intersection) {
      rotate([0,0,180])
        dbl_sway60(radius, which==7 ? dir : other_dir(dir), rail, road, part,
                   gutter=gutter);
      dbl_curve_sway60(radius, dir, rail, road, part,
                       far_side=(which==8), gutter=gutter);
    }
  } else if (which==9 || which==10) {
    // double-to-single crossover (crossing #9 is technically a gantlet)
    // both curved
    union_or_intersection(is_intersection=is_intersection) {
      dbl_curve_sway60_left(radius, rail, road, part,
                            far_side=(which==10), gutter=gutter);
      dbl_curve_sway60_right(radius, rail, road, part,
                             far_side=(which==10), gutter=gutter);
    }
  }
}

// Some switches are mirror symmetric, but the `dir` parameter is used for
// those which aren't.
module switch60(radius, which, dir="left", rail=false, road=false, part="all",
                gutter=true, is_intersection=false) {
  if (part=="all") {
    difference() {
      switch60(radius, which, dir, rail, road, "body", gutter);
      switch60(radius, which, dir, rail, road, "hole");
      switch60(radius, which, dir, rail, road, "connector");
      if (rail) difference() {
        switch60(radius, which, dir, rail, road, "ties");
        switch60(radius, which, dir, rail, road, "body",
                 gutter=false, is_intersection=true);
      }
    }
  } else if (which==1 || which==2) {
    union_or_intersection(is_intersection=is_intersection) {
      straight60(radius, rail, road, part);
      curve60(radius, dir, rail, road, part);
      if (which == 2) { curve60(radius, other_dir(dir), rail, road, part); }
      else if (is_intersection) bogus60(radius);
    }
  } else if (which==3) {
    union_or_intersection(is_intersection=is_intersection) {
      straight60(radius, rail, road, part);
      curve60(radius, dir=dir, rail=rail, road=road, part=part);
      rotate([0,0,180]) curve60(radius, dir=dir, rail=rail, road=road, part=part);
    }
  } else if (which==4 || which==5) {
    union_or_intersection(is_intersection=is_intersection) {
      curve60_left(radius, rail, road, part);
      curve60_right(radius, rail, road, part);
      if (which==5) {
        rotate([0,0,120]) curve60_right(radius, rail, road, part);
      } else if (is_intersection) bogus60(radius);
    }
  } else if (which==6) {
    // single-to-double straight switch
    union_or_intersection(is_intersection=is_intersection) {
      dbl_sway60_left(radius, rail, road, part, gutter=gutter);
      dbl_sway60_right(radius, rail, road, part, gutter=gutter);
    }
  } else if (which==7 || which==8) {
    // curved double-to-straight single wye
    union_or_intersection(is_intersection=is_intersection) {
      dbl_curve60(radius, dir=dir, rail=rail, road=road, part=part,
                  gutter=gutter);
      rotate([0,0,180])
        dbl_sway60(radius, dir=(which==7 ? dir : other_dir(dir)),
                   rail=rail, road=road, part=part, gutter=false,
                   offset=(which==7 ? 1 : 0));
    }
  } else if (which==9 || which==10) {
    // straight double-to-curved single wye
    union_or_intersection(is_intersection=is_intersection) {
      dbl_straight60(radius, rail=rail, road=road, part=part,
                     gutter=gutter);
      dbl_curve_sway60(radius, dir=dir, rail=rail, road=road, part=part,
                       just_curve=true, far_side=(which==10), gutter=false);
    }
  } else if (which==11 || which==12) {
    // curved double to curved single wye
    union_or_intersection(is_intersection=is_intersection) {
      dbl_curve60(radius, dir=dir, rail=rail, road=road, part=part,
                  gutter=gutter);
      dbl_curve_sway60(radius, dir=other_dir(dir), rail=rail, road=road,
                       part=part, far_side=(which==12), gutter=false);
    }
  } else if (which==13) {
    // double-track crossover
    union_or_intersection(is_intersection=is_intersection) {
      dbl_straight60(radius, rail, road, part, gutter=false);
      dbl_sway60(radius, dir, rail, road, part, sway_far=true);
    }
  } else if (which==14) {
    // single-to-double curved switch
    union_or_intersection(is_intersection=is_intersection) {
      dbl_curve_sway60(radius, dir, rail, road, part, gutter=gutter);
      dbl_curve_sway60(radius, dir, rail, road, part,
                       far_side=true, gutter=gutter);
    }
  } else if (which==15 || which==16) {
    // single-to-double curved switch, with right single curve
    union_or_intersection(is_intersection=is_intersection) {
      dbl_curve_sway60(radius, dir, rail, road, part, gutter=gutter);
      dbl_curve_sway60(radius, dir, rail, road, part,
                       far_side=true, gutter=gutter);
      dbl_curve_sway60(radius, other_dir(dir), rail, road, part,
                       far_side=(which==16), gutter=gutter);
    }
  }
}

module misc60(radius, which, rail=false, road=false, part="all", is_intersection=false) {
  if (part=="all") {
    difference() {
      misc60(radius, which, rail, road, "body");
      misc60(radius, which, rail, road, "hole");
      misc60(radius, which, rail, road, "connector");
      if (rail) difference() {
        misc60(radius, which, rail, road, "ties");
        misc60(radius, which, rail, road, "body", is_intersection=true);
      }
    }
  } else if (which==1) {
    union_or_intersection(is_intersection=is_intersection) {
      curve60_left(radius, rail, road, part);
      curve60_right(radius, rail, road, part);
      rotate([0,0,180]) curve60_left(radius, rail, road, part);
      rotate([0,0,180]) curve60_right(radius, rail, road, part);
    }
  } else if (which==2) {
    union_or_intersection(is_intersection=is_intersection) {
      curve60_left(radius, rail, road, part);
      curve60_right(radius, rail, road, part);
      rotate([0,0,-60]) curve60_right(radius, rail, road, part);
    }
  } else if (which==3) {
    union_or_intersection(is_intersection=is_intersection) {
      rotate([0,0,60]) straight60(radius, rail, road, part);
      rotate([0,0,120]) straight60(radius, rail, road, part);
      rotate([0,0,60]) curve60_left(radius, rail, road, part);
      rotate([0,0,120]) curve60_right(radius, rail, road, part);
    }
  } else if (which==4) {
    union_or_intersection(is_intersection=is_intersection) {
      rotate([0,0,0]) curve60_left(radius, rail, road, part);
      rotate([0,0,-120]) curve60_left(radius, rail, road, part);
      rotate([0,0,120]) curve60_left(radius, rail, road, part);
      rotate([0,0,60]) curve60_left(radius, rail, road, part);
    }
  }
}

// centered on the hex center
module straight60(radius, rail=false, road=false, part="all", trim_ties=true) {

  if (part=="all") {
    difference() {
      straight60(radius, rail, road, "body");
      straight60(radius, rail, road, "hole");
      straight60(radius, rail, road, "connector");
      straight60(radius, rail, road, "ties", trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      straight60(radius, rail=rail, road=road, part="ties", trim_ties=false);
      straight60(radius, rail=rail, road=road, part="body");
    }
  } else {
    if (part=="body") {
      translate([wood_width()/2,-straight_length(radius)/2,0])
        rotate([0,0,90]) wood_track(straight_length(radius), false);
    } else if (part=="connector") {
      translate([0,-straight_length(radius)/2,0])
        loose_wood_cutout();
      translate([0,straight_length(radius)/2,0])
        rotate([0,0,180]) loose_wood_cutout();
    } else if (part=="hole" || part=="ties") {
      do_rails_or_roads(rail=rail, road=road, part=part) {
        /* rails */
        translate([0,-straight_length(radius)/2,0])
        wood_rails_and_ties(radius, part=(part=="hole"?"rails":part));
        /* roads */
        translate([0,-straight_length(radius)/2,0])
        wood_road_and_stripes(radius);
      }
    }
  }
}

module half_dbl_straight60(radius, rail=false, road=false, part="all") {
  half_straight60(radius, rail=rail, road=road, part=part, double=true);
}

module half_straight60(radius, rail=false, road=false, part="all", trim_ties=true, double=false) {

  if (part=="all") {
    difference() {
      half_straight60(radius, rail, road, "body", double=double);
      half_straight60(radius, rail, road, "hole", double=double);
      half_straight60(radius, rail, road, "connector", double=double);
      half_straight60(radius, rail, road, "ties", trim_ties=false, double=double);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      half_straight60(radius, rail=rail, road=road, part="ties",
                      trim_ties=false, double=double);
      half_straight60(radius, rail=rail, road=road, part="body", double=double);
    }
  } else if (part=="body" || part=="connector") {
    translate([0,-straight_length(radius)/4,0])
      if (double) {
        dbl_straight60(radius/2, rail=rail, road=road, part=part);
      } else {
        straight60(radius/2, rail=rail, road=road, part=part);
      }
  } else {
    // hole and ties are unscaled to preserve consistent spacing.
    if (double) {
      dbl_straight60(radius, rail=rail, road=road, part=part);
    } else {
      straight60(radius, rail=rail, road=road, part=part);
    }
  }
}

module curve60(radius, dir, rail=false, road=false, part="all",
               trim_ties=true) {
  if (dir=="right") { curve60_right(radius, rail, road, part, trim_ties); }
  else if (dir=="left") { curve60_left(radius, rail, road, part, trim_ties); }
  else { echo("bad direction", dir); }
}

// centered on the hex center
module curve60_right(radius, rail=false, road=false, part="all",
                     trim_ties=true) {
  scale([-1,1,1]) curve60_left(radius, rail, road, part, trim_ties);
}

// centered on the hex center
module curve60_left(radius, rail=false, road=false, part="all",
                    trim_ties=true) {
  inner_radius = radius - (wood_width()/2);

  if (part=="all") {
    difference() {
      curve60_left(radius, rail, road, "body");
      curve60_left(radius, rail, road, "hole");
      curve60_left(radius, rail, road, "connector");
      curve60_left(radius, rail, road, "ties", trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      curve60_left(radius, rail=rail, road=road, part="ties", trim_ties=false);
      curve60_left(radius, rail=rail, road=road, part="body");
    }
  } else {
    translate([-radius,-straight_length(radius)/2,0]) {
      if (part=="body") {
        wood_track_arc(inner_radius, 60, false);
      } else if (part=="connector") {
        translate([radius,0,0])
          loose_wood_cutout();
        rotate([0,0,60]) translate([radius,0,0]) rotate([0,0,180])
          loose_wood_cutout();
      } else if (part=="hole" || part=="ties") {
        do_rails_or_roads(rail=rail, road=road, part=part, mirror_symmetric=false) {
          /* rails */
          wood_rails_and_ties_arc(radius, angle=60, part=(part=="hole"?"rails":part));
          /* roads */
          wood_road_and_stripes_arc(radius, angle=60);
        }
      }
    }
  }
}

module wood_rails_and_ties(radius, part="both") {
  epsilon = .1;
  do_rails = (part=="both" || part=="rails");
  do_ties = (part=="both" || part=="ties");

  if (do_rails) {
    translate([wood_width()/2,0,0])
      rotate([0,0,90]) wood_rails(straight_length(radius));
  }

  spacing = tie_spacing(radius);
  num=ceil((straight_length(radius)/spacing)/2);

  // ties.
  for (i = [-num:1:num] ) {
    translate([0,(straight_length(radius)/2)+(i-.5)*spacing,0]) {
      if (do_ties) {
        translate([-wood_width()/2-epsilon, -tie_width()/2, wood_height()-tie_height()])
          cube([wood_width()+2*epsilon, tie_width(), wood_height()]);
      }
      if (do_rails) for (j=[1,-1]) scale([j,1,1]) {
        translate([-(wood_well_spacing()/2)-wood_well_width(),
                   -tie_width()/2, wood_well_height() - well_tie_height()])
          cube([wood_well_width(), tie_width(), wood_height()]);
      }
    }
  }
}

module wood_road_and_stripes(radius) {
  epsilon = 1;

  translate([-road_width()/2,-epsilon,road_height()])
    cube([road_width(), straight_length(radius) + 2*epsilon, wood_height()]);

  spacing = tie_spacing(radius)*2;
  num=ceil((straight_length(radius)/spacing)/2);

  // stripes.
  for (i = [-num:1:num] ) {
    translate([0,(straight_length(radius)/2)+(i+.25)*spacing,0]) {
      translate([-stripe_width()/2,0,road_height()-stripe_height()])
        cube([stripe_width(),spacing/2, stripe_height() + epsilon]);
    }
  }
}


module wood_road_and_stripes_arc(radius, angle) {
  epsilon = 1;
  translate([0,0,road_height()]) {
    difference() {
      pie(radius + road_width()/2, angle, wood_height());
      translate([0,0,-epsilon])
        pie(radius - road_width()/2, angle + 2*epsilon,
            wood_height() + 2*epsilon, -epsilon);
    }
  }
  angle_increment = tie_angle(radius)*2;
  num=ceil((angle/angle_increment)/2);

  // stripes.
  for (i = [-num:1:num] ) {
    rotate([0,0,(angle/2)+(i-0.25)*angle_increment]) difference() {
      translate([0,0,road_height()-stripe_height()])
        pie(radius + stripe_width()/2, angle_increment/2,
            stripe_height() + epsilon);
      translate([0,0,road_height()-stripe_height()-epsilon])
        pie(radius - stripe_width()/2, angle_increment/2 + 2*epsilon,
            stripe_height() + 3*epsilon, -epsilon);
    }
  }
}

module wood_rails_and_ties_arc(radius, angle, part="both") {
  epsilon=.1;
  do_rails = (part=="both" || part=="rails");
  do_ties = (part=="both" || part=="ties");

  inner_radius = radius - (wood_width()/2);

  angle_increment = tie_angle(radius);

  num=ceil((angle/angle_increment)/2);

  if (do_rails) wood_rails_arc(inner_radius, angle);

  for (i = [-num:1:num] ) {
    rotate([0,0,(angle/2)+(i*angle_increment)]) {
      if (do_ties) {
      translate([radius - wood_width()/2 - epsilon, -tie_width()/2, wood_height()-tie_height()])
        cube([wood_width()+2*epsilon, tie_width(), wood_height()]);
      }
      if (do_rails) for (j=[1,-1]) {
        translate([radius+j*(wood_well_spacing()/2)-(j<0?wood_well_width():0),
                   -tie_width()/2, wood_well_height() - well_tie_height()])
          cube([wood_well_width(), tie_width(), wood_height()]);
      }
    }
  }
}

// Double-track pieces.
// centered on the hex center
module dbl_straight60(radius, rail=false, road=false, part="all",
                      gutter=true, trim_ties=true) {
  epsilon=.1;

  if (part=="all") {
    difference() {
      dbl_straight60(radius, rail, road, "body", gutter);
      dbl_straight60(radius, rail, road, "hole");
      dbl_straight60(radius, rail, road, "connector");
      dbl_straight60(radius, rail, road, "ties", trim_ties=false);
    }
  } else if (part=="body" && gutter) {
    dbl_straight60(radius, rail=rail, road=road, part="body", gutter=false);
    dbl_straight60(radius, rail=rail, road=road, part="gutter");
  } else if (part=="gutter") {
    translate([0,0,wood_height()/2]) {
      cube([double_gutter()+epsilon, straight_length(radius),
            wood_well_height()], center=true);
      cube([double_gutter()/2, straight_length(radius),
            wood_height()], center=true);
    }
  } else {
    for (i=[1,-1]) translate([i*(wood_width()+double_gutter())/2, 0, 0])
      straight60(radius, rail=rail, road=road, part=part, trim_ties=trim_ties);
  }
}

module dbl_curve60(radius, dir, rail=false, road=false, part="all",
                   gutter=true, trim_ties=true) {
  if (dir=="right") {
    dbl_curve60_right(radius, rail, road, part, gutter, trim_ties);
  } else if (dir=="left") {
    dbl_curve60_left(radius, rail, road, part, gutter, trim_ties);
  } else { echo("bad direction", dir); }
}

module dbl_curve60_right(radius, rail=false, road=false, part="all",
                         gutter=true, trim_ties=true) {
  scale([-1,1,1])
    dbl_curve60_left(radius, rail, road, part, gutter, trim_ties);
}

module dbl_curve60_left(radius, rail=false, road=false, part="all",
                        gutter=true, trim_ties=true) {
  epsilon=.1;

  if (part=="all") {
    difference() {
      dbl_curve60_left(radius, rail, road, "body", gutter);
      dbl_curve60_left(radius, rail, road, "hole");
      dbl_curve60_left(radius, rail, road, "connector");
      dbl_curve60_left(radius, rail, road, "ties", trim_ties=false);
    }
  } else if (part=="body" && gutter) {
    dbl_curve60_left(radius, rail=rail, road=road, part="body", gutter=false);
    dbl_curve60_left(radius, rail=rail, road=road, part="gutter");
  } else if (part=="gutter") {
    translate([-radius,-straight_length(radius)/2,wood_height()/2]) {
      difference() {
        pie_centered(radius + double_gutter()/2 + epsilon, 60,
                     wood_well_height());
        pie_centered(radius - double_gutter()/2 - epsilon, 60 + 2*epsilon,
                     wood_well_height() + epsilon, -epsilon);
      }
      difference() {
        pie_centered(radius + double_gutter()/4, 60, wood_height());
        pie_centered(radius - double_gutter()/4, 60 + 2*epsilon, wood_height() + epsilon, -epsilon);
      }
    }
  } else {
    translate([-radius,-straight_length(radius)/2,0]) {
      for (i=[1,-1]) {
        nr = radius + i*(wood_width()+double_gutter())/2;
        ns = 2*nr/sqrt(3);
        translate([nr,ns/2,0])
          curve60_left(nr, rail=rail, road=road, part=part,
                       trim_ties=trim_ties);
      }
    }
  }
}

module dbl_sway60(radius, dir, rail=false, road=false, part="all",
                  sway_far=false, offset=0.5, gutter=true,
                  trim_ties=true) {
  if (dir=="right") {
    dbl_sway60_right(radius, rail, road, part, sway_far, offset, gutter,
                     trim_ties);
  } else if (dir=="left") {
    dbl_sway60_left(radius, rail, road, part, sway_far, offset, gutter,
                    trim_ties);
  } else { echo("bad direction", dir); }
}

module dbl_sway60_right(radius, rail=false, road=false, part="all",
                        sway_far=false, offset=0.5, gutter=true,
                        trim_ties=true) {
  scale([-1,1,1])
    dbl_sway60_left(radius=radius, rail=rail, road=road, part=part,
                    sway_far=sway_far, offset=offset, gutter=gutter,
                    trim_ties=trim_ties);
}

module dbl_sway60_left(radius, rail=false, road=false, part="all",
                       sway_far=false, offset=0.5, gutter=true,
                       trim_ties=true) {
  epsilon=.1;
  sway_radius = radius; // for now.
  sway_offset = (wood_width() + double_gutter()) / (sway_far ? 1 : 2);
  sway_angle = acos(1 - ((sway_offset/2)/sway_radius)); // in degrees
  sway_length = 2 * sway_radius * sin(sway_angle);
  stub_length = (straight_length(radius) - sway_length)/2;
  stub_offset = ((offset*2)-1) * stub_length;
  if (stub_length < 0) echo("WARNING: negative stub length: ", stub_length);

  if (part=="all") {
    difference() {
      dbl_sway60_left(radius, rail, road, "body", sway_far, offset, gutter);
      dbl_sway60_left(radius, rail, road, "hole", sway_far, offset);
      dbl_sway60_left(radius, rail, road, "connector", sway_far, offset);
      dbl_sway60_left(radius, rail, road, "ties", sway_far, offset, trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      dbl_sway60_left(radius, rail=rail, road=road, part="ties",
                      sway_far=sway_far, offset=offset, trim_ties=false);
      dbl_sway60_left(radius, rail=rail, road=road, part="body",
                      sway_far=sway_far, offset=offset, gutter=false);
    }
  } else if (part=="body" && gutter) {
    dbl_sway60_left(radius, rail=rail, road=road, part="body",
                    sway_far=sway_far, offset=offset, gutter=false);
    dbl_sway60_left(radius, rail=rail, road=road, part="gutter",
                    sway_far=sway_far, offset=offset);
  } else if (part=="gutter") {
    dbl_straight60(radius, rail=rail, road=road, part="gutter");
  } else if (part=="gutter") { // Old version.
    for(i=sway_far?[-1,1]:[1]) rotate([0,0,(i+1)*90]) for(j=["well","ridge"]){
      gutter_off = (j=="well") ? (wood_height()-wood_well_height()) : 0;
      gutter_width = (j=="well") ? double_gutter()+epsilon : double_gutter()/2;
      gutter_length = stub_length + (i*stub_offset);
      translate([-gutter_width/2, -straight_length(radius)/2, gutter_off/2])
        cube([gutter_width, gutter_length, wood_height() - gutter_off]);
    }
  } else {
    translate([sway_far ? 0 : (-sway_offset/2),stub_offset,0])
      for(i=[-1,1]) rotate([0,0,(i+1)*90])
      translate([sway_offset/2,-(straight_length(radius)/2)+(i*stub_offset),0]) {
      if (part=="body") {
        translate([wood_width()/2,0,0])
          rotate([0,0,90]) wood_track(stub_length + (i*stub_offset) + epsilon, false);
        translate([-sway_radius,stub_length + (i*stub_offset),0])
          wood_track_arc(sway_radius - (wood_width()/2), sway_angle + epsilon,
                        false);
      } else if (part=="connector") {
        loose_wood_cutout();
      } else if (part=="hole" || part=="ties") {
        do_rails_or_roads(rail=rail, road=road, part=part, mirror_symmetric=false) {
          /* rails */
          for (which=["rails","ties"]) {
            which_height = (which=="rails" ? 0 : -well_tie_height());
            difference() {
              union() {
                if (part=="hole") {
                  translate([wood_width()/2, 0, which_height])
                    rotate([0,0,90])
                    wood_rails(stub_length + (i*stub_offset) + epsilon, bevel_ends=false);
                  translate([-sway_radius, stub_length + (i*stub_offset), which_height])
                    wood_rails_arc(sway_radius - (wood_width()/2),
                                   sway_angle + epsilon, bevel_ends=false);
                }
                if (part=="ties" && which=="ties") {
                  translate([-wood_width()/2 - epsilon, 0,
                             wood_height() - tie_height()]) {
                    cube([wood_width() + 2*epsilon,
                          stub_length + (i*stub_offset) + epsilon,
                          wood_height()]);
                    translate([-sway_offset/2, stub_length+(i*stub_offset), 0])
                      cube([wood_width() + (sway_offset/2) + 2*epsilon,
                            straight_length(radius)/2 - stub_length +
                              tie_width()/2 + epsilon, wood_height()]);
                  }
                }
              }
              if (which=="ties") {
                /* cut out ties. */
                spacing = tie_spacing(radius);
                num=ceil((straight_length(radius)/2)/spacing);
                extra=ceil((i*stub_offset)/spacing);
                for (j = [-num:1:(extra+1)] ) {
                  ypos = (straight_length(radius)/2) + (j*spacing);
                  translate([0,ypos,wood_height()])
                    cube([2*(wood_width()+sway_offset),
                          spacing - tie_width(),
                          2*wood_height()], center=true);
                }
              }
            }
          }
          /* roads */
          for (which=["road","stripe"]) {
            which_width = (which=="road") ? road_width() : stripe_width();
            which_height = road_height() -
              (which=="road" ? 0 : stripe_height());
            difference() {
              union() {
                translate([-which_width/2, -epsilon, which_height])
                  cube([which_width, stub_length + (i*stub_offset) + 2*epsilon, wood_height()]);
                translate([-sway_radius, stub_length + (i*stub_offset), which_height])
                  difference() {
                    pie(sway_radius + which_width/2, sway_angle + epsilon,
                        wood_height());
                    translate([0,0,-epsilon])
                      pie(sway_radius - which_width/2, sway_angle + 3*epsilon,
                          wood_height() + 2*epsilon, -epsilon);
                  }
              }
              if (which=="stripe") {
                /* cut out stripes */
                spacing = tie_spacing(radius)*2;
                num=ceil((straight_length(radius)/spacing)/2);
                extra=ceil((i*stub_offset)/spacing);
                for (j = [-num:1:(extra+1)] ) {
                  ypos = (straight_length(radius)/2) + (j*spacing);
                  translate([0,ypos,wood_height()])
                    cube([wood_width()+sway_offset,spacing/2, 2*wood_height()],
                          center=true);
                }
              }
            }
          }
        }
      }
    }
  }
}

module dbl_curve_sway60(radius, dir, rail=false, road=false, part="all",
                        just_curve=false, far_side=false, gutter=true,
                        trim_ties=true) {
  if (dir=="right") {
    dbl_curve_sway60_right(radius, rail, road, part, just_curve, far_side,
                           gutter, trim_ties);
  } else if (dir=="left") {
    dbl_curve_sway60_left(radius, rail, road, part, just_curve, far_side,
                          gutter, trim_ties);
  } else { echo("bad direction", dir); }
}

module dbl_curve_sway60_right(radius, rail=false, road=false, part="all",
                              just_curve=false, far_side=false, gutter=true,
                              trim_ties=true) {
  scale([-1,1,1])
    dbl_curve_sway60_left(radius, rail, road, part, just_curve, far_side,
                          gutter, trim_ties);
}

module dbl_curve_sway60_left(radius, rail=false, road=false, part="all",
                             just_curve=false, far_side=false, gutter=true,
                             trim_ties=true) {
  epsilon=.1;
  if (part=="all") {
    difference() {
      dbl_curve_sway60_left(radius, rail, road, "body",
                            just_curve, far_side, gutter);
      dbl_curve_sway60_left(radius, rail, road, "hole",
                            just_curve, far_side);
      dbl_curve_sway60_left(radius, rail, road, "connector",
                            just_curve, far_side);
      dbl_curve_sway60_left(radius, rail, road, "ties",
                            just_curve, far_side, trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      dbl_curve_sway60_left(radius, rail=rail, road=road, part="ties",
                            just_curve=just_curve, far_side=far_side,
                            trim_ties=false);
      dbl_curve_sway60_left(radius, rail=rail, road=road, part="body",
                            just_curve=just_curve, far_side=far_side,
                            gutter=false);
    }
  } else if (part=="body" && gutter) {
    dbl_curve_sway60_left(radius, rail=rail, road=road, part="body",
                          just_curve=just_curve, far_side=far_side,
                          gutter=false);
    dbl_curve_sway60_left(radius, rail=rail, road=road, part="gutter",
                          just_curve=just_curve, far_side=far_side);
  } else if (part=="gutter") {
    dbl_curve60_left(radius, rail=rail, road=road, part="gutter");
    // Add a bit extra to connect to far_side curve (otherwise there
    // is a small gap, because far_side curve starts with straight segment)
    if (far_side) {
      translate([0,-straight_length(radius)/4,wood_height()/2])
        cube([double_gutter(),straight_length(radius)/2,wood_well_height()],
             center=true);
    }
  } else {
    offset = (wood_width() + double_gutter())/2;
    new_radius = radius - 2*offset;
    far_offset = far_side ? (wood_width() + double_gutter())/sqrt(3) : 0;
    if (part=="connector") {
      rotate([0,0,-120]) translate([0,-straight_length(radius)/2,0])
        loose_wood_cutout();
    }
    translate([(far_side?1:-1)*(wood_width()+double_gutter())/2,-straight_length(radius)/2,0]) {
      if (part=="body") {
        if (!just_curve) {
          translate([wood_width()/2,0,0]) rotate([0,0,90])
            wood_track(offset*sqrt(3) - far_offset + epsilon, false);
        }
        translate([-new_radius,offset*sqrt(3) - far_offset,0]) {
          wood_track_arc(new_radius - (wood_width()/2), 60, false);
          rotate([0,0,60])
            translate([wood_width()/2+new_radius,-epsilon,0]) rotate([0,0,90])
              if (far_side) wood_track(2*far_offset + epsilon, false);
        }
      } else if (part=="connector" && !just_curve) {
        loose_wood_cutout();
      } else if (part=="hole" || part=="ties") {
        do_rails_or_roads(rail=rail, road=road, part=part, mirror_symmetric=false) {
          /* rails */
          for (which=["rails","ties"]) {
            which_height = (which=="rails" ? 0 : -well_tie_height());
            difference() {
              union() {
                if (part=="hole") {
                  if (!just_curve)
                    translate([wood_width()/2, 0, which_height])
                    rotate([0,0,90])
                    wood_rails(offset*sqrt(3) - far_offset + epsilon, bevel_ends=false);
                  translate([-new_radius,offset*sqrt(3) - far_offset, which_height]) {
                    wood_rails_arc(new_radius - (wood_width()/2), 60, bevel_ends=false);
                    if (far_side) rotate([0,0,60])
                      translate([wood_width()/2+new_radius,-epsilon,0])
                      rotate([0,0,90])
                      wood_rails(2*far_offset + epsilon, false);
                  }
                }
                if (part=="ties" && which=="ties") {
                  translate([-radius+(far_side ? -offset : offset), 0,
                             wood_height() - tie_height()])
                    cube([radius + 2*offset, radius, wood_height()]);
                }
              }
              if (which=="ties") {
                /* cut out ties */
                angle = 60;
                angle_increment = tie_angle(radius);
                num=ceil((angle/angle_increment)/2);
                tie_angle = 180 * tie_width() / (PI * radius);
                for (j = [-num:1:num]) {
                  translate([-radius+(far_side ? -offset : offset), 0,
                             wood_height()])
                    pie_centered(radius + wood_width() + double_gutter(),
                                 angle_increment - tie_angle,
                                 2*wood_height(),
                                 (angle/2)+((j-.5)*angle_increment) + (tie_angle/2));
                }
              }
            }
          }
          /* roads */
          for (which=["road","stripe"]) {
            which_width = (which=="road") ? road_width() : stripe_width();
            which_height = road_height() -
              (which=="road" ? 0 : stripe_height());
            difference() {
              union() {
                if (!just_curve)
                  translate([-which_width/2, -epsilon, which_height])
                    cube([which_width,
                          offset*sqrt(3) - far_offset + 2*epsilon,
                          wood_height()]);
                translate([-new_radius,offset*sqrt(3) - far_offset, which_height]) {
                  difference() {
                    pie(new_radius + which_width/2, 60 + epsilon, wood_height());
                    translate([0,0,-epsilon])
                      pie(new_radius - which_width/2, 60 + 3*epsilon,
                          wood_height() + 2*epsilon, -epsilon);
                  }
                  if (far_side) rotate([0,0,60])
                    translate([new_radius - which_width/2,-epsilon,0])
                      cube([which_width, 2*far_offset + 2*epsilon,
                            wood_height()]);
                }
              }
              if (which=="stripe") {
                /* cut out stripes */
                angle = 60;
                angle_increment = tie_angle(radius)*2;
                num=ceil((angle/angle_increment)/2);
                for (j = [-num:1:num]) {
                  translate([-radius+(far_side ? -offset : offset), 0,
                             wood_height()])
                    pie_centered(radius + wood_width() + double_gutter(),
                                 angle_increment/2,
                                 2*wood_height() + epsilon,
                                 (angle/2)+((j-.25)*angle_increment));
                }
              }

            }
          }
        }
      }
    }
  }
}

module do_rails_or_roads(rail=false, road=false, part="both", mirror_symmetric=true) {
  if (road&&rail ? false : rail) { children(0); /* rail on top */ }
  if (road) {
    if (part != "ties") children(1); /* road on top */
  }

  translate([0,0,wood_height()/2])
    rotate([0, mirror_symmetric ? 180 : 0, mirror_symmetric ? 180 : 0])
    scale([1, 1, mirror_symmetric ? 1 : -1])
    translate([0,0,-wood_height()/2]) {
    if (rail) { children(0); /* rail on bottom */ }
    if (road&&rail ? false : road) {
      if (part != "ties") children(1); /* road on bottom */
    }
  }
}

module loose_wood_cutout() {
  rotate([0,0,90]) wood_cutout();
  // shorten the pieces slightly to make them fit less tightly
  trim=1;//mm
  cube([wood_width()+double_gutter()+trim, trim, 2*wood_height()+trim], center=true);
}
module pie_centered(radius, angle, height, spin=0) {
  translate([0,0,-height/2]) pie(radius, angle, height, spin=spin);
}

module building60(radius, rail=false, road=false, part="all", trim_ties=true) {
  if (part=="all") {
    difference() {
      building60(radius, rail, road, "body");
      building60(radius, rail, road, "hole");
      building60(radius, rail, road, "connector");
      building60(radius, rail, road, "ties", trim_ties=false);
    }
  } else {
    straight60(radius, rail=rail, road=road, part=part, trim_ties=trim_ties);
    if (part=="body") {
      translate([wood_width()/2,0,0])
        #wood_plug();
    } else if (part=="hole") {
      driveway_width = 46.6;
      translate([0,-driveway_width/2, road_height()])
        cube([wood_width(), driveway_width, wood_height()]);
      translate([0,0,wood_height()/2]) for (j=[1,-1]) scale([1,1,j])
      translate([wood_width()/2 + 3.8 + 0.5, -driveway_width/2, 7.4 - wood_height()/2])
        cube([8, driveway_width, wood_height()]);
    }
  }
}

module slope60(radius, rail=false, road=false, part="all", trim_ties=true) {
  epsilon=.1;
  rise=62;  // standard module rise
  length=straight_length(radius);
  slope_angle=atan2(rise,length);
  slope_radius=sqrt(pow(rise,2)+pow(length,2))/(4*sin(slope_angle));

  //hypo= sqrt(pow(rise/2,2) + pow(length/2,2));
  //echo(length=length,slope_angle=slope_angle,slope_radius=slope_radius,hypo=hypo);

  if (part=="all") {
    difference() {
      slope60(radius, rail, road, "body");
      slope60(radius, rail, road, "hole");
      slope60(radius, rail, road, "connector");
      slope60(radius, rail, road, "ties", trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      slope60(radius, rail=rail, road=road, part="ties", trim_ties=false);
      slope60(radius, rail=rail, road=road, part="body");
    }
  } else {
    for(i=[-1,1]) rotate([0,0,(i+1)*90]) {
      if (part=="body") {
        translate([-wood_width()/2,-length/2,i*(rise/2)])
          wood_track_slope(slope_radius + wood_height()/2,
                           -i*(2*slope_angle + epsilon),
                           rails=false);
      } else if (part=="connector") {
        translate([0, -length/2, i*(rise/2) + wood_height()/2])
          /* scale cutout in z direction to account for track curvature */
          scale([1,1,2]) translate([0,0,-wood_height()/2])
            loose_wood_cutout();
      } else if (part=="hole" || part=="ties") {
        do_rails_or_roads(rail=rail, road=road, part=part) {
          /* rails */
          for (which=["rails","ties"]) {
            which_height = (which=="rails" ? 0 : -well_tie_height());
            difference() {
              union() {
                if (part=="hole") {
                  translate([-wood_width()/2,-length/2,i*(rise/2) + which_height])
                    wood_rails_slope(slope_radius + wood_height()/2,
                                     -i*(2*slope_angle + epsilon),
                                     bevel_ends=false);
                }
                if (part=="ties" && which=="ties") {
                  translate([-wood_width()/2, -length/2,
                             i*(rise/2) + wood_height() - tie_height()])
                    wood_track_slope(slope_radius + wood_height()/2,
                                     -i*(2*slope_angle + epsilon),
                                     rails=false);
                }
              }
              if (which=="ties") {
                /* cut out ties */
                spacing = tie_spacing(radius);
                num=ceil((straight_length(radius)/2)/spacing);
                for (j = [-num:1:0] ) {
                  ypos = (j*spacing);
                  translate([0,ypos,0])
                    cube([2*wood_width(),
                          spacing - tie_width(),
                          rise + 4*wood_height()], center=true);
                }
              }
            }
          }
          /* roads */
          for (which=["road","stripe"]) {
            which_width = (which=="road") ? road_width() : stripe_width();
            which_height = road_height() - (which=="road" ? 0 : stripe_height());
            difference() {
              union() {
                scale([which_width/wood_width(),1,1])
                  translate([-wood_width()/2, -length/2,
                             i*(rise/2) + which_height])
                    wood_track_slope(slope_radius + wood_height()/2,
                                     -i*(2*slope_angle + epsilon),
                                     rails=false);
              }
              if (which=="stripe") {
                /* cut out stripes */
                spacing = tie_spacing(radius)*2;
                num=ceil((straight_length(radius)/spacing)/2);
                for (j = [-num:1:0] ) {
                  ypos = (j*spacing);
                  translate([0,ypos,0])
                    cube([2*wood_width(),spacing/2, rise + 4*wood_height()],
                          center=true);
                }
              }
            }
          }
        }
      }
    }
  }
}
