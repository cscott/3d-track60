/* Dave Barber's 60-degree brio track system */

/* [Global] */
part = "curve"; // [curve:Basic 60 degree curve,straight:Straight,crossing1:Crossing #1,crossing2:Crossing #2,crossing3:Crossing #3,crossing4:Crossing #4,crossing5:Crossing #5,switch1:Switch #1,switch2:Switch #2,switch3:Switch #3,switch4:Switch #4,switch5:Switch #5,switch6:Switch #6,switch7:Switch #7,switch1_rail:Switch #1 alternate (rails),switch1_road:Switch #1 alternate (road),switch4_rail:Switch #4 alternate (rails),switch4_road:Switch #4 alternate (road),switch8:Switch #8 (single to double),misc1:Mixed switch and crossing #1,misc2:Mixed switch and crossing #2,misc3:Mixed switch and crossing #3,misc4:Mixed switch and crossing #4,roundabout:Roundabout (assembled),roundabout_inner:Roundabout (inner piece),roundabout_outer:Roundabout (outer piece),dogbone:Male-male connector,dbl_straight:Double-track straight,dbl_curve:Double-track curve]

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
// However, our wtrak-like system works nicely
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

function stripe_width() = 2;
function stripe_height() = 1;

// gutter between double-track pieces.
function double_gutter() = 10;

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
  } else if (part=="switch1") {
      switch60(r, 1, rail=true, road=true);
  } else if (part=="switch2") {
      switch60(r, 2, rail=true, road=true);
  } else if (part=="switch3") {
      switch60(r, 3, rail=true, road=true);
  } else if (part=="switch4") {
      switch60(r, 4, rail=true, road=true);
  } else if (part=="switch5") {
      switch60(r, 5, rail=true, road=true);
  } else if (part=="switch6") {
      switch60(r, 6, rail=true, road=true);
  } else if (part=="switch7") {
      switch60(r, 7, rail=true, road=true);
  } else if (part=="switch8") {
      switch60(r, 8, rail=true, road=true);
  } else if (part=="switch1_rail") {
      // Rails on both sides, can flip to make switch #2
      switch60(r, 1, rail=true);
  } else if (part=="switch1_road") {
      // Roads on both sides, can flip to make switch #2
      switch60(r, 1, road=true);
  } else if (part=="switch4_rail") {
      // Rails on both sides, can flip to make switch #5
      switch60(r, 4, rail=true);
  } else if (part=="switch4_road") {
      // Roads on both sides, can flip to make switch #5
      switch60(r, 4, road=true);
  } else if (part=="misc1") {
      misc60(r, 1, rail=true, road=true);
  } else if (part=="misc2") {
      misc60(r, 2, rail=true, road=true);
  } else if (part=="misc3") {
      misc60(r, 3, rail=true, road=true);
  } else if (part=="misc4") {
      misc60(r, 4, rail=true, road=true);
  } else if (part=="roundabout") {
      track60_demo(part="roundabout_inner",r=r);
      track60_demo(part="roundabout_outer",r=r);
  } else if (part=="roundabout_inner"||part=="roundabout_outer") {
      ring=45; // just enough for a female connector
      difference() {
        rotate([0,0,90])
        roundabout_custom(outer=ring, inner=straight_length(r)-ring, num=3, rails=false,
          inner_piece=(part!="roundabout_outer"),
          outer_piece=(part!="roundabout_inner"));
        // Add our own rails
        difference() {
          for (p=["hole","ties"]) {
            if (part=="roundabout_inner") {
              intersection() {
                straight60(radius=r, rail=true, part=p);
                if (p=="ties")
                  cylinder(d=straight_length(r)-ring-10,h=wood_height()*3,center=true);
              }
            } else if (part=="roundabout_outer") {
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
    scale([1,1,wood_well_height()/wood_height()]) dogbone(true);
  } else if (part=="dbl_straight") {
     dbl_straight60(r, road=true, rail=true);
  } else if (part=="dbl_curve") {
     dbl_curve60_left(r, road=true, rail=true);
  } else if (part=="dbl_sway") {
     dbl_sway60_left(r, road=true, rail=true);
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

module crossing60(radius, which, rail=false, road=false, part="all", is_intersection=false) {
  if (part=="all") {
    difference() {
      crossing60(radius, which, rail, road, "plug");
      crossing60(radius, which, rail, road, "hole");
      crossing60(radius, which, rail, road, "connector");
      if (rail) difference() {
        crossing60(radius, which, rail, road, "ties");
        crossing60(radius, which, rail, road, "plug", is_intersection=true);
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
  }
}

module switch60(radius, which, rail=false, road=false, part="all", is_intersection=false) {
  if (part=="all") {
    difference() {
      switch60(radius, which, rail, road, "plug");
      switch60(radius, which, rail, road, "hole");
      switch60(radius, which, rail, road, "connector");
      if (rail) difference() {
        switch60(radius, which, rail, road, "ties");
        switch60(radius, which, rail, road, "plug", is_intersection=true);
      }
    }
  } else if (which==1 || which==2 || which==3) {
    union_or_intersection(is_intersection=is_intersection) {
      straight60(radius, rail, road, part);
      if (which != 2) { curve60_left(radius, rail, road, part); }
      else if (is_intersection) bogus60(radius);
      if (which != 1) { curve60_right(radius, rail, road, part); }
      else if (is_intersection) bogus60(radius);
    }
  } else if (which==4 || which==5) {
    union_or_intersection(is_intersection=is_intersection) {
      straight60(radius, rail, road, part);
      curve60(radius, dir=(which==4?"left":"right"), rail=rail, road=road, part=part);
      rotate([0,0,180]) curve60(radius, dir=(which==4?"left":"right"), rail=rail, road=road, part=part);
    }
  } else if (which==6 || which==7) {
    union_or_intersection(is_intersection=is_intersection) {
      curve60_left(radius, rail, road, part);
      curve60_right(radius, rail, road, part);
      if (which==7) {
        rotate([0,0,120]) curve60_right(radius, rail, road, part);
      } else if (is_intersection) bogus60(radius);
    }
  } else if (which==8) {
    // single-to-double switch
    union_or_intersection(is_intersection=is_intersection) {
      dbl_sway60_left(radius, rail, road, part);
      dbl_sway60_right(radius, rail, road, part);
    }
  }
}

module misc60(radius, which, rail=false, road=false, part="all", is_intersection=false) {
  if (part=="all") {
    difference() {
      misc60(radius, which, rail, road, "plug");
      misc60(radius, which, rail, road, "hole");
      misc60(radius, which, rail, road, "connector");
      if (rail) difference() {
        misc60(radius, which, rail, road, "ties");
        misc60(radius, which, rail, road, "plug", is_intersection=true);
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
module straight60(radius, rail=false, road=false, part="all") {

  if (part=="all") {
    difference() {
      straight60(radius, rail, road, "plug");
      straight60(radius, rail, road, "hole");
      straight60(radius, rail, road, "connector");
      straight60(radius, rail, road, "ties");
    }
  } else {
    translate([0,-straight_length(radius)/2,0]) {
      if (part=="plug") {
        translate([wood_width()/2,0,0]) rotate([0,0,90])
          wood_track(straight_length(radius), false);
      } else if (part=="connector") {
        loose_wood_cutout();
        translate([0,straight_length(radius),0])
          rotate([0,0,180]) loose_wood_cutout();
      } else if (part=="hole" || part=="ties") {
        do_rails_or_roads(rail=rail, road=road, part=part) {
          /* rails */
          wood_rails_and_ties(radius, part=(part=="hole"?"rails":part));
          /* roads */
          wood_road_and_stripes(radius);
        }
      }
    }
  }
}

module curve60(radius, dir, rail=false, road=false, part="all") {
  if (dir=="right") { curve60_right(radius, rail, road, part); }
  else if (dir=="left") { curve60_left(radius, rail, road, part); }
  else { echo("bad direction", dir); }
}

// centered on the hex center
module curve60_right(radius, rail=false, road=false, part="all") {
  scale([-1,1,1]) curve60_left(radius, rail, road, part);
}

// centered on the hex center
module curve60_left(radius, rail=false, road=false, part="all") {
  inner_radius = radius - (wood_width()/2);

  if (part=="all") {
    difference() {
      curve60_left(radius, rail, road, "plug");
      curve60_left(radius, rail, road, "hole");
      curve60_left(radius, rail, road, "connector");
      curve60_left(radius, rail, road, "ties");
    }
  } else {
    translate([-radius,-straight_length(radius)/2,0]) {
      if (part=="plug") {
        wood_track_arc(inner_radius, 60, false);
      } else if (part=="connector") {
        translate([radius,0,0])
          loose_wood_cutout();
        rotate([0,0,60]) translate([radius,0,0]) rotate([0,0,180])
          loose_wood_cutout();
      } else if (part=="hole" || part=="ties") {
        do_rails_or_roads(rail=rail, road=road, part=part) {
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

  road_width = wood_well_spacing() + 2*wood_well_width();
  translate([-road_width/2,-epsilon,wood_well_height()])
    cube([road_width, straight_length(radius) + 2*epsilon, wood_height()]);

  spacing = tie_spacing(radius)*2;
  num=ceil((straight_length(radius)/spacing)/2);

  // stripes.
  for (i = [-num:1:num] ) {
    translate([0,(straight_length(radius)/2)+(i+.25)*spacing,0]) {
      translate([-stripe_width()/2,0,wood_well_height()-stripe_height()])
        cube([stripe_width(),spacing/2, stripe_height() + epsilon]);
    }
  }
}


module wood_road_and_stripes_arc(radius, angle) {
  epsilon = 1;
  road_width = wood_well_spacing() + 2*wood_well_width();
  translate([0,0,wood_well_height()]) {
    difference() {
      pie(radius + road_width/2, angle, wood_height());
      translate([0,0,-epsilon])
        pie(radius - road_width/2, angle + 2*epsilon,
            wood_height() + 2*epsilon, -epsilon);
    }
  }
  angle_increment = tie_angle(radius)*2;
  num=ceil((angle/angle_increment)/2);

  // stripes.
  for (i = [-num:1:num] ) {
    rotate([0,0,(angle/2)+(i-0.25)*angle_increment]) difference() {
      translate([0,0,wood_well_height()-stripe_height()])
        pie(radius + stripe_width()/2, angle_increment/2,
            stripe_height() + epsilon);
      translate([0,0,wood_well_height()-stripe_height()-epsilon])
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
module dbl_straight60(radius, rail=false, road=false, part="all") {
  epsilon=.1;

  if (part=="all") {
    difference() {
      union() {
        dbl_straight60(radius, rail, road, "plug");
        dbl_straight60(radius, rail, road, "gutter");
      }
      dbl_straight60(radius, rail, road, "hole");
      dbl_straight60(radius, rail, road, "connector");
      dbl_straight60(radius, rail, road, "ties");
    }
  } else if (part=="gutter") {
    translate([0,0,wood_height()/2]) {
      cube([double_gutter()+epsilon, straight_length(radius),
            wood_well_height()], center=true);
      cube([double_gutter()/2, straight_length(radius),
            wood_height()], center=true);
    }
  } else {
    for (i=[1,-1]) translate([i*(wood_width()+double_gutter())/2, 0, 0])
      straight60(radius, rail=rail, road=road, part=part);
  }
}

module dbl_curve60_left(radius, rail=false, road=false, part="all") {
  epsilon=.1;

  if (part=="all") {
    difference() {
      union() {
        dbl_curve60_left(radius, rail, road, "plug");
        dbl_curve60_left(radius, rail, road, "gutter");
      }
      dbl_curve60_left(radius, rail, road, "hole");
      dbl_curve60_left(radius, rail, road, "connector");
      dbl_curve60_left(radius, rail, road, "ties");
    }
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
          curve60_left(nr, rail=rail, road=road, part=part);
      }
    }
  }
}


module dbl_sway60_left(radius, rail=false, road=false, part="all") {
  epsilon=.1;
  sway_radius = radius; // for now.
  sway_offset = (wood_width() + double_gutter()) / 2;
  sway_angle = acos(1 - ((sway_offset/2)/sway_radius)); // in degrees
  sway_length = 2 * sway_radius * sin(sway_angle);
  stub_length = (straight_length(radius) - sway_length)/2;

  if (part=="all") {
    difference() {
      union() {
        dbl_sway60_left(radius, rail, road, "plug");
        dbl_sway60_left(radius, rail, road, "gutter");
      }
      dbl_sway60_left(radius, rail, road, "hole");
      dbl_sway60_left(radius, rail, road, "connector");
      dbl_sway60_left(radius, rail, road, "ties");
    }
  } else {
    translate([-sway_offset/2,0,0])
      for(i=[0,180]) rotate([0,0,i])
      translate([sway_offset/2,-straight_length(radius)/2,0]) {
      if (part=="plug") {
        translate([wood_width()/2,0,0])
          rotate([0,0,90]) wood_track(stub_length + epsilon, false);
        translate([-sway_radius,stub_length,0])
          wood_track_arc(sway_radius - (wood_width()/2), sway_angle + epsilon,
                        false);
      } else if (part=="connector") {
        loose_wood_cutout();
      } else if (part=="hole" || part=="ties") {
        do_rails_or_roads(rail=rail, road=road, part=part) {
          /* rails */
          for (which=["rails","ties"]) {
            which_height = (which=="rails" ? 0 : -well_tie_height());
            difference() {
              union() {
                if (part=="hole") {
                  translate([wood_width()/2,0,which_height]) rotate([0,0,90])
                    wood_rails(stub_length + epsilon, bevel_ends=false);
                  translate([-sway_radius,stub_length,which_height])
                    wood_rails_arc(sway_radius - (wood_width()/2),
                                   sway_angle + epsilon, bevel_ends=false);
                }
                if (part=="ties" && which=="ties") {
                  translate([-wood_width()/2 - epsilon, 0,
                             wood_height() - tie_height()]) {
                    cube([wood_width() + 2*epsilon, stub_length + epsilon,
                          wood_height()]);
                    translate([-sway_offset/2,stub_length,0])
                      cube([wood_width() + (sway_offset/2) + 2*epsilon,
                            straight_length(radius)/2 - stub_length +
                              tie_width()/2 + epsilon, wood_height()]);
                  }
                }
              }
              if (which=="ties") {
                /* cut out ties. */
                spacing = tie_spacing(radius);
                num=ceil((straight_length(radius)/spacing)/2);
                for (i = [-num:1:1] ) {
                  ypos = (straight_length(radius)/2) + (i-.5)*spacing;
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
            road_width = wood_well_spacing() + 2*wood_well_width();
            which_width = (which=="road") ? road_width : stripe_width();
            which_height = wood_well_height() -
              (which=="road" ? 0 : stripe_height());
            difference() {
              union() {
                translate([-which_width/2, -epsilon, which_height])
                  cube([which_width, stub_length + 2*epsilon, wood_height()]);
                translate([-sway_radius, stub_length, which_height])
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
                for (i = [-num:1:1] ) {
                  ypos = (straight_length(radius)/2) + (i)*spacing;
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

module dbl_sway60_right(radius, rail=false, road=false, part="all") {
  scale([-1,1,1]) dbl_sway60_left(radius, rail, road, part);
}

module do_rails_or_roads(rail=false, road=false, part="both") {
  if (road&&rail ? false : rail) { children(0); /* rail on top */ }
  if (road) {
    if (part != "ties") children(1); /* road on top */
  }

  translate([0,0,wood_height()/2]) scale([1,1,-1])
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
  cube([wood_width()+trim, trim, 2*wood_height()+trim], center=true);
}
module pie_centered(radius, angle, height, spin=0) {
  translate([0,0,-height/2]) pie(radius, angle, height, spin=spin);
}
