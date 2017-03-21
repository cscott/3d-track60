/* Dave Barber's 60-degree brio track system */

// XXX switch6 says "may not be a valid 2-manifold"
// XXX -right/-left,-rail/-road will probably need to be
//     -left-road, -right-road, etc for pieces w/ double connectors.

// Based on:
//   http://tamivox.org/dave/train/sect14/gallery.pdf
// Added: O - mirrored B
// Added: R - half straight
// Added: 0 - dbl crossover
// Added: 1-7: combinations of double-to-single paths
// Added: 8 - dbl ramp
// Added: 9 - dbl buffer

// Translation between old and new names:
// curve: BS
// dbl_curve: bs
// straight: AT
// dbl_straight: at
// half_straight: AR
// half_dbl_straight: ar
// crossing1: CS
// crossing2: BV
// crossing3: AW
// crossing4: EV
// crossing5: AZ
// crossing6: 00
// crossing7: 24/12*
// crossing8: 42/21
// crossing9: 14
// crossing10:41
// switch1: BT/BU*
// switch2: DU
// switch3: EU/ET*
// switch4: DS
// switch5: HS
// switch6: 22
// switch7: bs2A/osA2*
// switch8: bsA2/os2A*
// switch9: au1A/auA4*
// switch10:auA1/au4A*
// switch11:bs1A/osA4*
// switch12:bsA1/os4A*
// switch13:au0A/auA0*
// switch14:44/11*
// switch15:54/15*
// switch16:45/51*
// switch17: CT
// misc1: JS
// misc2: GS
// misc3: EW
// misc4: KS
// dbl_buffer: 88
// dbl_ramp: 99
// grade-crossing3: AT-AU/AU-AT (need to fix this)

/* [Global] */
part = "straight"; // [curve:Basic 60 degree curve,straight:Straight,half_straight:Special half-length straight,half_dbl_straight:Special half-length double straight,crossing1:Crossing #1 (two curves),crossing2:Crossing #2 (one curve one straight),crossing3:Crossing #3 (two straights),crossing4:Crossing #4 (two curves one straight),crossing5:Crossing #5 (three straights),crossing6:Crossing #6 (double xover),crossing7-left:Crossing #7 (double to single; one left one straight),crossing7-right:Crossing #7 (double to single; one right one straight),crossing7-rail:Crossing #7 alternate (rails),crossing7-road:Crossing #7 alternate (road),crossing8-left:Crossing #8 (double to single xover; one left one straight),crossing8-right:Crossing #8 (double to single xover; one right one straight),crossing8-rail:Crossing #8 alternate (rails),crossing8-road:Crossing #8 alternate (road),crossing9:Crossing #9 (double to single; one left one right),crossing10:Crossing #10 (double to single xover; one left one right),switch1-left:Switch #1 (left hand),switch1-right:Switch #1 (right hand),switch1-rail:Switch #1 alternate (rails),switch1-road:Switch #1 alternate (road),switch2:Switch #2,switch3-left:Switch #3 (left hand),switch3-right:Switch #3 (right hand),switch3-rail:Switch #3 alternate (rails),switch3-road:Switch #3 alternate (road),switch4:Switch #4,switch5:Switch #5,switch6:Switch #6 (single to double),switch7-left:Switch #7 (left hand curved double to straight single wye),switch7-right:Switch #7 (right hand curved double to straight single wye),switch7-rail:Switch #7 alternate (rails),switch7-road:Switch #7 alternate (road),switch8-left:Switch #8 (left hand curved double to xover straight single wye),switch8-right:Switch #8 (right hand curved double to xover straight single wye),switch8-rail:Switch #8 alternate (rails),switch8-road:Switch #8 alternate (road),switch9-left:Switch #9 (straight double to left curved single wye),switch9-right:Switch #9 (straight double to right curved single wye),switch9-rail:Switch #9 alternate (rails),switch9-road:Switch #9 alternate (road),switch10-left:Switch #10 (straight double to xover left curved single wye),switch10-right:Switch #10 (straight double to xover right curved single wye),switch10-rail:Switch #10 alternate (rails),switch10-road:Switch #10 alternate (road),switch11-left:Switch #11 (left hand curved double to right hand curved single wye),switch11-right:Switch #11 (right hand curved double to left hand curved single wye),switch11-rail:Switch #11 alternate (rails),switch11-road:Switch #11 alternate (road),switch12-left:Switch #12 (left hand curved double to xover right hand curved single wye),switch12-right:Switch #12 (right hand curved double to xover left hand curved single wye),switch12-rail:Switch #12 alternate (rails),switch12-road:Switch #12 alternate (road),switch13-left:Switch #13 (double straight left xover),switch13-right:Switch #13 (double straight right xover),switch13-rail:Switch #13 alternate (rails),switch13-road:Switch #13 alternate (road),switch14-left:Switch #14 (left hand curved double to single),switch14-right:Switch #14 (right hand curved double to single),switch14-rail:Switch #14 alternate (rails),switch14-road:Switch #14 alternate (road),switch15-left:Switch #15 (single-to-double left curved switch with right single curve),switch15-right:Switch #15 (single-to-double right curved switch with left single curve),switch15-rail:Switch #15 alternate (rails),switch15-road:Switch #15 alternate (road),switch16-left:Switch #16 (single-to-double left curved switch with right xover single curve),switch16-right:Switch #16 (single-to-double right curved switch with left xover single curve),switch16-rail:Switch #16 alternate (rails),switch16-road:Switch #16 alternate (road),switch17:Switch #17 (crossing #1 with added straight),misc1:Mixed switch and crossing #1,misc2:Mixed switch and crossing #2,misc3:Mixed switch and crossing #3,misc4:Mixed switch and crossing #4,roundabout-rail:Roundabout (assembled; w/ rails),roundabout-inner-straight-rail:Roundabout (inner piece; straight; w/ rails),roundabout-inner-crossing4-rail:Roundabout (inner piece; three way crossing; w/ rails),roundabout-outer-rail:Roundabout (outer piece; w/ rails),roundabout-road:Roundabout (assembled; w/ road),roundabout-inner-straight-road:Roundabout (inner piece; straight; w/ road),roundabout-inner-crossing4-road:Roundabout (inner piece; three way crossing; w/ road),roundabout-outer-road:Roundabout (outer piece; w/ road),dogbone:Male-male connector,dbl_straight:Double-track straight,dbl_curve:Double-track curve,slope:Straight slope,slope-rail:Straight slope (rail only),slope-road:Straight slope (road only),riser:Riser (print on its side),buffer-rail:Buffer for rail,buffer-road:Buffer for road,ramp-rail:Ramp for rail,ramp-road:Ramp for road,dbl_buffer-rail:Double-track buffer for rail,dbl_buffer-road:Double-track buffer for road,dbl_ramp-rail:Double-track ramp for rail,dbl_ramp-road:Double-track ramp for road,barn:John Deere Barn connector,barn-dogbone:Special dogbone to connect John Deere Barn connector track,carwash:Texaco Carwash connector,firehouse:Thomas' Firehouse connector,recycling-left:Recycling center adapter (left side),recycling-right:Recycling center adapter (right side),recycling-split-left:Recycling center adapter (left side/one road one rail),recycling-split-right:Recycling center adapter (right side/one road one rail),thomas-crossing:Adapter for Thomas' grade crossing,grade-crossing:Grade crossing (straight),grade-crossing3:Grade crossing (crossing #3)]

/* [Hidden] */
use <../dotscad/pie.scad>;
use <../trains/tracklib.scad>;
use <../trains/track-wooden/dog-bone.scad>;
use <../trains/track-wooden/track-standard.scad>;
use <./roundabout.scad>
use <./strutil.scad>

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
// For comparison, according to
// http://www.woodenrailway.info/track/trackguide.html
// the standard brio "E" curve has a centerline radius of 202mm
// and the tighter brio "E1" curve has a centerline radius of 110mm
// and the typical straights are 4.5in, 5.5in, and 8.5in (compared to our 7in)

// 64mm is brio standard; some other sets have 62mm risers.
// Split the difference, so we're more or less compatible with either.
function riser_height() = 63;

function straight_length(radius) = 2*radius/sqrt(3);

/* Option 1: */
function tie_spacing(basic_radius=basic_radius) =
  basic_radius*((1/sqrt(3))-(PI/6))*2/*to taste*/;
function tie_angle(arc_radius, basic_radius=basic_radius) =
  180 * tie_spacing(basic_radius) / (PI * arc_radius);
/* */

/* Option 2:
function tie_angle(arc_radius, basic_radius=basic_radius) = 6;
function tie_spacing(basic_radius=basic_radius) =
  (tie_angle(basic_radius, basic_radius) * PI * basic_radius) / 180;
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

function flip_surface(surface) =
  let (s=split(surface, "-")) str(s[1], "-", s[0]);

function surface_offsets(surface="road-rail") =
  let(off = wood_height() - road_height())
  [/*top*/ startswith(surface, "road-") ? off : 0,
   /*bottom*/ endswith(surface, "-road") ? off : 0 ];
// Since double-track connector is not mirror-symmetric, pieces which
// include a double track connector should be blanked on the side
// where the double-connector would be "wrong".  That is, rail has to
// be on the bottom and road on the top in order for the connector
// to mate properly.
function blank_dbl_surface(surface) =
  startswith(surface, "rail-") ?
    blank_dbl_surface(str("blank-", split(surface, "-")[1])) :
  endswith(surface, "-road") ?
    str(split(surface, "-")[0], "-blank") :
  surface;

// Make curves look nice.
$fn = 120;

track60_demo(part);

function track60_parse_suffix(part) =
  let(n=len(part), suf5=substr(part, n-5, 5), suf6=substr(part, n-6, 6))
  (suf5=="-left" || suf5=="-road" || suf5=="-rail") ? substr(part, 0, n-5) :
  (suf6=="-right") ? substr(part, 0, n-6) : part;

// Sample instantiations
module track60_demo(part="curve_rail",r=basic_radius) {
  hex_edge = 2*r/3;

  base = track60_parse_suffix(part);
  suffix = substr(part, len(base), len(part)-len(base));

  dir=(suffix=="-right") ? "right" : "left";
  surface = // "<top>-<bottom>"
    suffix=="-rail" ? "rail-rail" :
    suffix=="-road" ? "road-road" :
    "road-rail";

  if (base=="curve") {
    curve60(r, dir, surface=surface);
  } else if (startswith(base, "name-")) {
    shortname60(r, substr(base, 5, len(base)-5), surface=surface);
  } else if (base=="straight") {
    straight60(r, surface=surface);
  } else if (base=="half_straight") {
    half_straight60(r, surface=surface);
  } else if (substr(base, 0, 8)=="crossing") {
    which = numat(base, 8, intonly=true);
    crossing60(r, which=which, dir=dir, surface=surface);
  } else if (substr(base, 0, 6)=="switch") {
    which = numat(base, 6, intonly=true);
    switch60(r, which=which, dir=dir, surface=surface);
  } else if (substr(base, 0, 4)=="misc") {
    which = numat(base, 4, intonly=true);
    misc60(r, which=which, surface=surface);
  } else if (base=="buffer" || base=="dbl_buffer" ||
             base=="ramp" || base=="dbl_ramp") {
    buffer_or_ramp60(r, surface=surface, which=base);
  } else if (base=="roundabout") {
    track60_demo(part=str("roundabout-inner-straight",suffix),r=r);
    track60_demo(part=str("roundabout-outer",suffix),r=r);
  } else if (base=="roundabout-inner-straight" ||
             base=="roundabout-inner-crossing4" ||
             base=="roundabout-outer") {
      is_outer = (base=="roundabout-outer");
      is_inner_straight = (base=="roundabout-inner-straight");
      ring=45; // just enough for a female connector
      difference() {
        rotate([0,0,90])
        roundabout_custom(outer=ring, inner=straight_length(r)-ring,
          num=3, rails=false, inner_num=(is_inner_straight?1:3),
          hub_height=(wood_well_height() - well_tie_height() - 1.2),
          clearance=0.8,
          inner_piece=!is_outer, outer_piece=is_outer);
        // Add our own rails
        difference() {
          for (p=startswith(surface, "road-")?["hole"]:["hole","ties"]) {
            if (!is_outer) {
              intersection() {
                if (is_inner_straight) {
                  straight60(radius=r, surface=surface, part=p);
                } else {
                  adjr = (straight_length(r)-ring)*sqrt(3)/2;
                  crossing60(radius=adjr, which=4, surface=surface, part=p);
                }
                if (p=="ties")
                  cylinder(d=straight_length(r)-ring-10,h=wood_height()*3,center=true);
              }
            } else if (is_outer) {
              difference() {
                crossing60(radius=r, which=5, surface=surface, part=p);
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
  } else if (base=="dbl_straight") {
    dbl_straight60(r, surface=blank_dbl_surface(surface));
  } else if (base=="dbl_curve") {
    dbl_curve60(r, dir=dir, surface=blank_dbl_surface(surface));
  } else if (base=="half_dbl_straight") {
    half_dbl_straight60(r, surface=blank_dbl_surface(surface));
  } else if (base=="barn-assembled") {
    track60_demo(part=str("barn",suffix),r=r);
    track60_demo(part=str("barn-dogbone",suffix),r=r);
  } else if (base=="barn") {
    barn60(r, surface=surface);
  } else if (base=="barn-dogbone") {
    barn60(r, surface=surface, part="dogbone");
  } else if (base=="carwash") {
    carwash60(r, surface=surface);
  } else if (base=="firehouse") {
    firehouse60(r, surface=blank_dbl_surface(surface));
  } else if (base=="recycling") {
    recycling60(r, dir=dir, surface=surface, split_surface=false);
  } else if (base=="recycling-split") {
    recycling60(r, dir=dir, surface=surface, split_surface=true);
  } else if (base=="grade-crossing") {
    grade_crossing60(r);
  } else if (base=="thomas-crossing") {
    thomas_crossing60(r, surface="rail-blank");
  } else if (base=="grade-crossing3") {
    grade_crossing360(r);
  } else if (base=="slope") {
    slope60(r, surface=surface);
  } else if (base=="riser") {
    riser60();
  } else if (base=="dbl_dogbone") {
    dbl_dogbone(surface=surface);
  } else if (base=="dbl_dogbone_plug") {
    dbl_dogbone_plug(surface=surface);
  }
}

// Based on http://tamivox.org/dave/train/sect14/gallery.pdf
function num_tracks_for_letter(s) =
  (toupper(s) != s[0]) ? num_tracks_for_letter(toupper(s)[0]) :
  (s == "A" || s == "S") ? 0 :
  (s == "B" || s == "O" || s == "R" || s == "T" || s == "U" || s == "V" ||
   s == "0" || s == "1" || s == "2" || s == "4" || s == "8" || s == "9" ) ? 1 :
  (s == "C" || s == "D" || s == "E" || s == "W" || s == "X" || s == "Y" ||
   s == "3" || s == "5" || s == "6" ) ? 2 :
  (s == "J" || s == "K" || s == "L") ? 4 :
  s == "M" ? 5 :
  s == "N" ? 6 : 3;

function num_tracks_for_shortname(s) = len(s) == 0 ? 0 :
  num_tracks_for_letter(s[0]) + num_tracks_for_letter(substr(s, 1, len(s)-1));

function name_has_dbl(s) = let (n=len(s)) n == 0 ? false :
  (let (c=s[0]) toupper(c) != c ? true :
  (c == "0" || c == "1" || c == "2" || c == "3" || c == "4" ||
   c == "5" || c == "6" || c == "7" || c == "8" || c == "9") ? true :
  name_has_dbl(substr(s, 1, n-1)));

module maybe_dbl_curve60(radius, dir, surface, part, is_double) {
  if (is_double) {
    dbl_curve60(radius, dir, surface=surface, part=part);
  } else {
    curve60(radius, dir, surface=surface, part=part);
  }
}

module maybe_dbl_straight60(radius, surface, part, is_double) {
  if (is_double) {
    dbl_straight60(radius, surface=surface, part=part);
  } else {
    straight60(radius, surface=surface, part=part);
  }
}

module decode_shortname(s, i, radius, surface, part) {
  off = len(s) - 1;
  n = (len(s) <= 0 || s[off] == "-") ? 0 :
    num_tracks_for_letter(s[off]);
  c = toupper(s[off]);
  is_double = (s[off] != c); // lowercase means double track
  dash_pos = indexof(s, "-");
  surf = dash_pos < 0 ? surface : flip_surface(surface);
  is_even = ((off - (dash_pos < 0 ? 0 : (dash_pos+1))) % 2) == 0;
  if (s == "") {
    /* nothing */
    if (part != "body") bogus60(radius);
  } else if (i >= n) {
    decode_shortname(substr(s, 0, len(s)-1), i-n, radius, surface, part);
  } else if (
    (c == "B" && i == 0) ||
    (c == "C" && i == 0) ||
    (c == "D" && i == 0) ||
    (c == "E" && i == 0) ||
    (c == "F" && i == 0) ||
    (c == "G" && i == 0) ||
    (c == "H" && i == 0) ||
    (c == "N" && i == 0) ||
    (c == "O" && i == 0)) {
    dir = (c == "O") ? "right" : "left";
    rotate([0,0,180])
      maybe_dbl_curve60(radius, dir, surf, part, is_double);
  } else if (
    (c == "I" && i == 0) ||
    (c == "J" && i == 0) ||
    (c == "K" && i == 0) ||
    (c == "L" && i == 0) ||
    (c == "M" && i == 0) ||
    (c == "N" && i == 1)) {
    rotate([0,0,120])
      maybe_dbl_curve60(radius, "left", surf, part, is_double);
  } else if (
    (c == "H" && i == 1) ||
    (c == "I" && i == 1) ||
    (c == "J" && i == 1) ||
    (c == "K" && i == 1) ||
    (c == "L" && i == 1) ||
    (c == "M" && i == 1) ||
    (c == "N" && i == 2)) {
    rotate([0,0,60])
      maybe_dbl_curve60(radius, "left", surf, part, is_double);
  } else if (
    (c == "E" && i == 1) ||
    (c == "F" && i == 1) ||
    (c == "K" && i == 2) ||
    (c == "L" && i == 2) ||
    (c == "M" && i == 2) ||
    (c == "N" && i == 3)) {
    rotate([0,0,0])
      maybe_dbl_curve60(radius, "left", surf, part, is_double);
  } else if (
    (c == "D" && i == 1) ||
    (c == "G" && i == 1) ||
    (c == "H" && i == 2) ||
    (c == "I" && i == 2) ||
    (c == "J" && i == 2) ||
    (c == "L" && i == 3) ||
    (c == "M" && i == 3) ||
    (c == "N" && i == 4)) {
    rotate([0,0,-60])
      maybe_dbl_curve60(radius, "left", surf, part, is_double);
  } else if (
    (c == "C" && i == 1) ||
    (c == "F" && i == 2) ||
    (c == "G" && i == 2) ||
    (c == "J" && i == 3) ||
    (c == "K" && i == 3) ||
    (c == "M" && i == 4) ||
    (c == "N" && i == 5)) {
    rotate([0,0,-120])
      maybe_dbl_curve60(radius, "left", surf, part, is_double);
  } else if (
    (c == "T" && i == 0) ||
    (c == "W" && i == 1) ||
    (c == "X" && i == 1) ||
    (c == "Z" && i == 2)) {
    rotate([0,0,60])
      maybe_dbl_straight60(radius, surf, part, is_double);
  } else if (
    (c == "U" && i == 0) ||
    (c == "W" && i == 0) ||
    (c == "Y" && i == 0) ||
    (c == "Z" && i == 0)) {
    maybe_dbl_straight60(radius, surf, part, is_double);
  } else if (
    (c == "V" && i == 0) ||
    (c == "X" && i == 0) ||
    (c == "Y" && i == 1) ||
    (c == "Z" && i == 1)) {
    rotate([0,0,-60])
      maybe_dbl_straight60(radius, surf, part, is_double);
  } else if (
    (c == "1" && i == 0) ||
    (c == "3" && i == 0) ||
    (c == "5" && i == 0) ||
    (c == "7" && i == 0)) {
    rotate([0,0,180])
    dbl_curve_sway60(radius, dir="right", surface=surf, part=part,
                     far_side=!is_even);
  } else if (
    (c == "2" && i == 0) ||
    (c == "3" && i == 1) ||
    (c == "6" && i == 0) ||
    (c == "7" && i == 1)) {
    dbl_sway60(radius, is_even ? "left" : "right", surface=surf, part=part);
  } else if (
    (c == "4" && i == 0) ||
    (c == "5" && i == 1) ||
    (c == "6" && i == 1) ||
    (c == "7" && i == 2)) {
    rotate([0,0,180])
    dbl_curve_sway60(radius, dir="left", surface=surf, part=part,
                     far_side=is_even);
  } else if ((c == "0" && i == 0)) {
    dbl_sway60(radius, is_even ? "left" : "right", surface=surf, part=part,
               sway_far=true);
  } else if (
    (c == "8" && i == 0) ||
    (c == "9" && i == 0)) {
    which = str("dbl_",
                is_even ? "left_" : "right_",
                c == "8" ? "buffer" : "ramp");
    rotate([0,0,180])
      buffer_or_ramp60(radius, surface=surf, part=part, which=which);
  } else if ((c == "R" && i == 0)) {
    half_straight60(radius, surface=surface, part=part, double=is_double);
  }
}

module union_or_intersection(is_intersection=false, nchildren=undef) {
  num = (nchildren!=undef) ? nchildren : $children;
  if (is_intersection) {
    for(i=[0:1:num-2]) {
      for(j=[i+1:1:num-1]) {
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

module with_bogus60(radius, disable=false) {
  children();
  if (!disable) bogus60(radius);
}

// module gantlet(...)?

// Most crossings are mirror symmetric, but the `dir` parameter is used for
// those which aren't.
module crossing60(radius, which, dir="left", surface="road-rail", part="all") {
  if (which==1) {
    shortname60(radius=radius, name="CS", surface=surface, part=part);
  } else if (which==2) {
    shortname60(radius=radius, name="BV", surface=surface, part=part);
  } else if (which==3) {
    shortname60(radius=radius, name="AW", surface=surface, part=part);
  } else if (which==4) {
    shortname60(radius=radius, name="EV", surface=surface, part=part);
  } else if (which==5) {
    shortname60(radius=radius, name="AZ", surface=surface, part=part);
  } else if (which==6) {
    // double crossover
    shortname60(radius=radius, name="00", surface=surface, part=part);
  } else if (which==7) {
    // double-to-single crossover (crossing #7 is technically a gantlet)
    // one straight, one curved.
    shortname60(radius=radius, name=(dir=="left"?"24":"12"), surface=surface, part=part);
  } else if (which==8) {
    // double-to-single crossover (crossing #7 is technically a gantlet)
    // one straight, one curved.
    shortname60(radius=radius, name=(dir=="left"?"42":"21"), surface=surface, part=part);
  } else if (which==9) {
    // double-to-single crossover (crossing #9 is technically a gantlet)
    // both curved
    shortname60(radius=radius, name="14", surface=surface, part=part);
  } else if (which==10) {
    // double-to-single crossover (crossing #9 is technically a gantlet)
    // both curved
    shortname60(radius=radius, name="41", surface=surface, part=part);
  }
}

// compute gutter cutout here, rather than in individual modules
// subtract body from cutout, subtract body+2mm from top of gutter
// compute road crossing cutouts of hole
module shortname60(radius=basic_radius, name="BS", surface="road-rail",
                   part="all", is_intersection=false) {
  if (part=="all") {
    has_double = name_has_dbl(name);
    nsurface = has_double ? blank_dbl_surface(surface) : surface;
    difference() {
      union() {
        shortname60(radius, name, nsurface, "body");
        if (has_double) shortname60(radius, name, nsurface, "gutter");
      }
      difference() {
        shortname60(radius, name, nsurface, "hole");
        // XXX flipped road
      }
      shortname60(radius, name, nsurface, "connector");
      difference() {
        with_bogus60(radius)
          shortname60(radius, name, nsurface, "ties");
        shortname60(radius, name, nsurface, "body", is_intersection=true);
      }
    }
  } else if (part=="gutter") {
    trim_gutter60() {
      shortname60(radius, name, surface, "gutter-body");
      shortname60(radius, name, surface, "body");
    }
  } else {
    num = num_tracks_for_shortname(name);
    union_or_intersection(is_intersection=is_intersection, nchildren=num) {
      decode_shortname(name, 0, radius, surface, part);
      decode_shortname(name, 1, radius, surface, part);
      decode_shortname(name, 2, radius, surface, part);
      decode_shortname(name, 3, radius, surface, part);
      decode_shortname(name, 4, radius, surface, part);
      decode_shortname(name, 5, radius, surface, part);
      decode_shortname(name, 6, radius, surface, part);
      decode_shortname(name, 7, radius, surface, part);
      decode_shortname(name, 8, radius, surface, part);
      decode_shortname(name, 9, radius, surface, part);
      decode_shortname(name, 10, radius, surface, part);
      decode_shortname(name, 11, radius, surface, part);
      decode_shortname(name, 12, radius, surface, part);
      decode_shortname(name, 13, radius, surface, part);
      decode_shortname(name, 14, radius, surface, part);
      decode_shortname(name, 15, radius, surface, part);
      decode_shortname(name, 16, radius, surface, part);
      decode_shortname(name, 17, radius, surface, part);
    }
  }
}

module trim_gutter60() {
  intersection() {
    children(0); // part="gutter-body"
    translate([0,0,wood_height()/2])
      cube([2*basic_radius, 2*basic_radius, wood_well_height()], center=true);
  }
  difference() {
    children(0); // part="gutter-body"
    minkowski() {
      cylinder(r=2, h=2*wood_height(), center=true, $fn=6);
      children(1); // part="body"
    }
  }
}

// Some switches are mirror symmetric, but the `dir` parameter is used for
// those which aren't.
module switch60(radius, which, dir="left", surface="road-rail", part="all",
                is_intersection=false) {
  bsurface=blank_dbl_surface(surface);
  if (part=="all") {
    difference() {
      union() {
        switch60(radius, which, dir, surface, "body");
        switch60(radius, which, dir, surface, "gutter");
      }
      switch60(radius, which, dir, surface, "hole");
      switch60(radius, which, dir, surface, "connector");
      difference() {
        with_bogus60(radius)
          switch60(radius, which, dir, surface, "ties");
        switch60(radius, which, dir, surface, "body",
                 is_intersection=true);
      }
    }
  } else if (which==1 || which==2) {
    union_or_intersection(is_intersection=is_intersection) {
      straight60(radius, surface, part);
      curve60(radius, dir, surface, part);
      if (which == 2) { curve60(radius, other_dir(dir), surface, part); }
      else if (is_intersection) bogus60(radius);
    }
  } else if (which==3) {
    union_or_intersection(is_intersection=is_intersection) {
      straight60(radius, surface, part);
      curve60(radius, dir=dir, surface=surface, part=part);
      rotate([0,0,180]) curve60(radius, dir=dir, surface=surface, part=part);
    }
  } else if (which==4 || which==5) {
    union_or_intersection(is_intersection=is_intersection) {
      curve60_left(radius, surface, part);
      curve60_right(radius, surface, part);
      if (which==5) {
        rotate([0,0,120]) curve60_right(radius, surface, part);
      } else if (is_intersection) bogus60(radius);
    }
  } else if (which==6) {
    // single-to-double straight switch
    union_or_intersection(is_intersection=is_intersection) {
      dbl_sway60_left(radius, bsurface, part);
      dbl_sway60_right(radius, bsurface, part);
    }
  } else if (which==7 || which==8) {
    // curved double-to-straight single wye
    union_or_intersection(is_intersection=is_intersection) {
      dbl_curve60(radius, dir=dir, surface=bsurface, part=part);
      rotate([0,0,180])
        dbl_sway60(radius, dir=(which==7 ? dir : other_dir(dir)),
                   surface=bsurface, part=part,
                   offset=(which==7 ? 1 : 0));
    }
  } else if (which==9 || which==10) {
    // straight double-to-curved single wye
    union_or_intersection(is_intersection=is_intersection) {
      dbl_straight60(radius, surface=bsurface, part=part);
      dbl_curve_sway60(radius, dir=dir, surface=bsurface, part=part,
                       just_curve=true, far_side=(which==10));
    }
  } else if (which==11 || which==12) {
    // curved double to curved single wye
    union_or_intersection(is_intersection=is_intersection) {
      dbl_curve60(radius, dir=dir, surface=bsurface, part=part);
      dbl_curve_sway60(radius, dir=other_dir(dir), surface=bsurface,
                       part=part, far_side=(which==12));
    }
  } else if (which==13) {
    // double-track crossover
    union_or_intersection(is_intersection=is_intersection) {
      dbl_straight60(radius, bsurface, part);
      dbl_sway60(radius, dir, bsurface, part, sway_far=true);
    }
  } else if (which==14) {
    // single-to-double curved switch
    union_or_intersection(is_intersection=is_intersection) {
      dbl_curve_sway60(radius, dir, bsurface, part);
      dbl_curve_sway60(radius, dir, bsurface, part,
                       far_side=true);
    }
  } else if (which==15 || which==16) {
    // single-to-double curved switch, with right single curve
    union_or_intersection(is_intersection=is_intersection) {
      dbl_curve_sway60(radius, dir, bsurface, part);
      dbl_curve_sway60(radius, dir, bsurface, part, far_side=true);
      dbl_curve_sway60(radius, other_dir(dir), bsurface, part,
                       far_side=(which==16));
    }
  } else if (which==17) {
    union_or_intersection(is_intersection=is_intersection) {
      straight60(radius, surface, part);
      curve60(radius, dir=dir, surface=surface, part=part);
      rotate([0,0,180])
        curve60(radius, dir=other_dir(dir), surface=surface, part=part);
    }
  }
}

module misc60(radius, which, surface="road-rail", part="all", is_intersection=false) {
  if (part=="all") {
    difference() {
      misc60(radius, which, surface, "body");
      misc60(radius, which, surface, "hole");
      misc60(radius, which, surface, "connector");
      difference() {
        with_bogus60(radius)
          misc60(radius, which, surface, "ties");
        misc60(radius, which, surface, "body", is_intersection=true);
      }
    }
  } else if (which==1) {
    union_or_intersection(is_intersection=is_intersection) {
      curve60_left(radius, surface, part);
      curve60_right(radius, surface, part);
      rotate([0,0,180]) curve60_left(radius, surface, part);
      rotate([0,0,180]) curve60_right(radius, surface, part);
    }
  } else if (which==2) {
    union_or_intersection(is_intersection=is_intersection) {
      curve60_left(radius, surface, part);
      curve60_right(radius, surface, part);
      rotate([0,0,-60]) curve60_right(radius, surface, part);
    }
  } else if (which==3) {
    union_or_intersection(is_intersection=is_intersection) {
      rotate([0,0,60]) straight60(radius, surface, part);
      rotate([0,0,120]) straight60(radius, surface, part);
      rotate([0,0,60]) curve60_left(radius, surface, part);
      rotate([0,0,120]) curve60_right(radius, surface, part);
    }
  } else if (which==4) {
    union_or_intersection(is_intersection=is_intersection) {
      rotate([0,0,0]) curve60_left(radius, surface, part);
      rotate([0,0,-120]) curve60_left(radius, surface, part);
      rotate([0,0,120]) curve60_left(radius, surface, part);
      rotate([0,0,60]) curve60_left(radius, surface, part);
    }
  }
}

module buffer_or_ramp60(radius, surface="road-rail", part="all",
                        which="buffer", trim_ties=true) {
  is_double = startswith(which, "dbl_");
  double_dir = concat(startswith(which, "dbl_right_") ? [] : [1],
                      startswith(which, "dbl_left_") ? [] : [-1],
                      startswith(which, "dbl_") ? [] : [0]);
  clearance = !is_double ? 1 :
    /* needs to clear double connector */ -8;
  half_width = wood_width()/2;
  inner_radius = radius - half_width;
  width_adj = inner_radius - sqrt(pow(inner_radius,2) - pow(half_width,2));
  buflen = straight_length(radius)/2 /* half straigth */
    - (straight_length(radius) - inner_radius) /* clear a curve60 */
    - width_adj /* shorten to account for non-zero width of buffer */
    - clearance /* a smidge more */;

  buffer_total_height = 33.5;
  buffer_stop_height = 10.5;
  buffer_stop_depth = 8;
  buffer_depth = buffer_total_height - wood_height() + 3.5;
  buffer_total_depth = buffer_depth + buffer_stop_depth;
  zigzag_width = 5;
  zigzag_depth = 0.6;
  num_zigzag = ceil(wood_width() / (2*zigzag_width));
  ramp_start = is_double ? 19 : 10;
  ramp_min_thick = 0.3; // height of first layer
  buffer = endswith(which, "buffer");
  ramp = endswith(which, "ramp");
  pivot_point = [0, -straight_length(radius)/2 + ramp_start, wood_height()];
  // road => road on top.  else rail on top.
  ramp_angle = atan2((startswith(surface, "road-") ?
                      road_height() : wood_well_height()) - ramp_min_thick,
                     buflen - ramp_start);
  // ensure surface ends in '-blank'
  nsurface = str(substr(surface, 0, indexof(surface, "-")), "-blank");

  if (part=="all") {
    difference() {
      union() {
        buffer_or_ramp60(radius, nsurface, "body", which=which);
        buffer_or_ramp60(radius, nsurface, "gutter", which=which);
      }
      buffer_or_ramp60(radius, nsurface, "hole", which=which);
      buffer_or_ramp60(radius, nsurface, "connector", which=which);
      buffer_or_ramp60(radius, nsurface, "ties", which=which, trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      with_bogus60(radius)
        buffer_or_ramp60(radius, surface=nsurface, part="ties", which=which, trim_ties=false);
      buffer_or_ramp60(radius, surface=nsurface, part="body", which=which);
    }
  } else if (part=="body" || part=="gutter" || part=="gutter-body") {
    newr = buflen*sqrt(3)/2;
    // short straight
    difference() {
      translate([0,-straight_length(radius)/2 + buflen/2, 0]) {
        if (is_double) {
          dbl_straight60(newr, surface=nsurface, part=part);
        } else {
          straight60(newr, surface=nsurface, part=part);
        }
      }
      if (is_double) {
        // trim the protruding double connector
        cube([2*radius, straight_length(radius)-2*buflen, 2*radius],
             center=true);
        // trim the "other side"
        if (len(double_dir) < 2) {
          for (i=double_dir)
            translate([-i*(wood_width()+double_gutter())/2, 0, 0])
              cube([wood_width(), 2*radius, 2*radius], center=true);
        }
      }
      if (ramp) {
        translate(pivot_point) rotate([-ramp_angle,0,0]) translate(-pivot_point)
        translate([0,0,radius + wood_height()])
          cube([2*radius, 2*radius, 2*radius], center=true);
      }
    }
    // male connector
    if (part=="body" && !is_double) translate([0,-straight_length(radius)/2, 0])
      scale([1,1,startswith(surface, "rail-")?1:(road_height()/wood_height())])
        rotate([0,0,-90]) wood_plug();
    // buffer
    if (part=="body" && buffer) {
      buffer_or_ramp60(radius, nsurface, part="buffer", which=which);
    }
  } else if (part=="buffer") {
    for (i=double_dir)
    translate([i*(wood_width()+double_gutter())/2, 0, 0])
    difference() {
      translate([-half_width,
               -straight_length(radius)/2 + buflen - buffer_depth,
               0]) {
        cube([wood_width(), buffer_depth, buffer_total_height]);
        translate([0, -buffer_stop_depth,
                   buffer_total_height - buffer_stop_height]) {
          cube([wood_width(), buffer_total_depth, buffer_stop_height]);
          // Fill in the underhang for support-free printing.
          rotate([-45,0,0])
          cube([wood_width(), buffer_stop_depth*sqrt(2)+1, buffer_stop_height]);
        }
      }
      translate([-half_width-1, -straight_length(radius)/2 + buflen,
                  wood_height()])
        rotate([45,0,0])
          cube([wood_width()+2, radius, 2*buffer_total_depth]);
      // zig zag pattern
      rotate([0,45,0])
      for (i=[-num_zigzag:1:num_zigzag])
        translate([i*2*zigzag_width,
                   -straight_length(radius)/2 + buflen - buffer_total_depth,
                   buffer_total_height - (buffer_stop_height/2)])
         cube([zigzag_width, 2*zigzag_depth, 2*buffer_total_height],
              center=true);
    }
  } else if (part=="connector" && !is_double) {
    bogus60(radius); /* nothing! */
  } else {
    // hole and ties are unscaled to preserve consistent spacing.
    // but make this single-sided (ie, use nsurface)
    difference() {
      with_bogus60(radius)
        if (is_double) {
          dbl_straight60(radius, surface=nsurface, part=part,
                         trim_ties=trim_ties);
        } else {
          straight60(radius, surface=nsurface, part=part,
                     trim_ties=trim_ties);
        }
      if (buffer) {
        buffer_or_ramp60(radius, nsurface, part="buffer", which=which);
      }
      // don't step on the front connector
      translate([0,-straight_length(radius)/2 - radius/2 - .01,0])
        cube([radius, radius, 3*wood_height()], center=true);
    }
    if (ramp && part != "connector") {
      difference() {
        with_bogus60(radius)
        translate(pivot_point) rotate([-ramp_angle,0,0]) translate(-pivot_point)
          if (is_double) {
            dbl_straight60(radius, surface=nsurface, part=part,
                           trim_ties=trim_ties);
          } else {
            straight60(radius, surface=nsurface, part=part,
                       trim_ties=trim_ties);
          }
        translate([0,0,-radius + ramp_min_thick])
          cube([2*radius, 2*radius, 2*radius], center=true);
      }
    }
  }
}

// centered on the hex center
module straight60(radius, surface="road-rail", part="all", trim_ties=true) {

  if (part=="all") {
    difference() {
      straight60(radius, surface, "body");
      straight60(radius, surface, "hole");
      straight60(radius, surface, "connector");
      straight60(radius, surface, "ties", trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      with_bogus60(radius)
        straight60(radius, surface=surface, part="ties", trim_ties=false);
      straight60(radius, surface=surface, part="body");
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
      do_rails_or_roads(surface=surface, part=part) {
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

module half_dbl_straight60(radius, surface="road-rail", part="all") {
  half_straight60(radius, surface=surface, part=part, double=true);
}

module half_straight60(radius, surface="road-rail", part="all", trim_ties=true,
                       double=false) {

  if (part=="all") {
    difference() {
      union() {
        half_straight60(radius, surface, "body", double=double);
        if (double) half_straight60(radius, surface, "gutter", double=double);
      }
      half_straight60(radius, surface, "hole", double=double);
      half_straight60(radius, surface, "connector", double=double);
      half_straight60(radius, surface, "ties", trim_ties=false, double=double);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      with_bogus60(radius)
        half_straight60(radius, surface=surface, part="ties",
                        trim_ties=false, double=double);
      half_straight60(radius, surface=surface, part="body", double=double);
    }
  } else if (part=="body" || part=="connector" ||
             part=="gutter" || part=="gutter-body") {
    translate([0,-straight_length(radius)/4,0])
      if (double) {
        dbl_straight60(radius/2, surface=surface, part=part);
      } else {
        straight60(radius/2, surface=surface, part=part);
      }
  } else {
    // hole and ties are unscaled to preserve consistent spacing.
    if (double) {
      dbl_straight60(radius, surface=surface, part=part);
    } else {
      straight60(radius, surface=surface, part=part);
    }
  }
}

module curve60(radius, dir, surface="road-rail", part="all",
               trim_ties=true) {
  if (dir=="right") { curve60_right(radius, surface, part, trim_ties); }
  else if (dir=="left") { curve60_left(radius, surface, part, trim_ties); }
  else { echo("bad direction", dir); }
}

// centered on the hex center
module curve60_right(radius, surface="road-rail", part="all",
                     trim_ties=true) {
  scale([-1,1,1]) curve60_left(radius, surface, part, trim_ties);
}

// centered on the hex center
module curve60_left(radius, surface="road-rail", part="all",
                    trim_ties=true) {
  inner_radius = radius - (wood_width()/2);

  if (part=="all") {
    difference() {
      curve60_left(radius, surface, "body");
      curve60_left(radius, surface, "hole");
      curve60_left(radius, surface, "connector");
      curve60_left(radius, surface, "ties", trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      with_bogus60(radius)
        curve60_left(radius, surface=surface, part="ties", trim_ties=false);
      curve60_left(radius, surface=surface, part="body");
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
        do_rails_or_roads(surface=surface, part=part, mirror_symmetric=false) {
          /* rails */
          wood_rails_and_ties_arc(radius, angle=60,
                                  part=(part=="hole"?"rails":part),
                                  basic_radius=radius);
          /* roads */
          wood_road_and_stripes_arc(radius, angle=60, basic_radius=radius);
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


module wood_road_and_stripes_arc(radius, angle,
                                 basic_radius=basic_radius,
                                 stripes_from_start=false,
                                 stripes_from_end=false) {
  epsilon = 1;
  translate([0,0,road_height()]) {
    difference() {
      pie(radius + road_width()/2, angle, wood_height());
      translate([0,0,-epsilon])
        pie(radius - road_width()/2, angle + 2*epsilon,
            wood_height() + 2*epsilon, -epsilon);
    }
  }
  angle_increment = tie_angle(arc_radius=radius, basic_radius=basic_radius)*2;
  num=ceil((angle/angle_increment)/2);

  // stripes.
  for (i = (stripes_from_start||stripes_from_end)?[-0.5:1:2*num]:[-num:1:num] ) {
    a =
      stripes_from_start ? (i-0.25)*angle_increment :
      stripes_from_end ? (angle - (i-0.25)*angle_increment) :
      ((angle/2) + ((i-0.25)*angle_increment));
    rotate([0,0,a]) difference() {
      translate([0,0,road_height()-stripe_height()])
        pie(radius + stripe_width()/2, angle_increment/2,
            stripe_height() + epsilon);
      translate([0,0,road_height()-stripe_height()-epsilon])
        pie(radius - stripe_width()/2, angle_increment/2 + 2*epsilon,
            stripe_height() + 3*epsilon, -epsilon);
    }
  }
}

module wood_rails_and_ties_arc(radius, angle, part="both", bevel_ends=false,
                               basic_radius=basic_radius,
                               ties_from_start=false,
                               ties_from_end=false) {
  epsilon=.1;
  do_rails = (part=="both" || part=="rails");
  do_ties = (part=="both" || part=="ties");

  inner_radius = radius - (wood_width()/2);

  angle_increment = tie_angle(arc_radius=radius, basic_radius=basic_radius);

  num=ceil((angle/angle_increment)/2);

  if (do_rails) wood_rails_arc(inner_radius, angle, bevel_ends=bevel_ends);

  for (i = (ties_from_start||ties_from_end)?[-0.5:1:2*num]:[-num:1:num] ) {
    a =
      ties_from_start ? i*angle_increment :
      ties_from_end ? (angle - i*angle_increment) :
      ((angle/2) + (i*angle_increment));
    rotate([0,0,a]) {
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
module dbl_straight60(radius, surface="road-rail", part="all", trim_ties=true) {
  epsilon=.1;

  if (part=="all") {
    difference() {
      union() {
        dbl_straight60(radius, surface, "body");
        dbl_straight60(radius, surface, "gutter");
      }
      dbl_straight60(radius, surface, "hole");
      dbl_straight60(radius, surface, "connector");
      dbl_straight60(radius, surface, "ties", trim_ties=false);
    }
  } else if (part=="gutter") {
    trim_gutter60() {
      dbl_straight60(radius, surface, "gutter-body");
      dbl_straight60(radius, surface, "body");
    }
  } else if (part=="gutter-body") {
    translate([0,0,wood_height()/2]) {
      cube([double_gutter()+epsilon, straight_length(radius),
            wood_height()], center=true);
    }
  } else if (part=="connector") {
    for (i=[0,180]) rotate([0,0,i])
      translate([0,-straight_length(radius)/2,0])
        dbl_connector(surface=surface, part=part);
  } else {
    for (i=[0,180]) rotate([0,0,i]) {
      translate([(wood_width()+double_gutter())/2, 0, 0])
        straight60(radius, surface=surface, part=part, trim_ties=trim_ties);
      translate([0,-straight_length(radius)/2,0])
        dbl_connector(surface=surface, part=part);
    }
  }
}

module dbl_curve60(radius, dir, surface="road-rail", part="all", trim_ties=true) {
  if (dir=="right") {
    dbl_curve60_right(radius, surface, part, trim_ties);
  } else if (dir=="left") {
    dbl_curve60_left(radius, surface, part, trim_ties);
  } else { echo("bad direction", dir); }
}

module dbl_curve60_right(radius, surface="road-rail", part="all", trim_ties=true) {
  rotate([0,0,120])
    dbl_curve60_left(radius, surface, part, trim_ties);
}

module dbl_curve60_left(radius, surface="road-rail", part="all", trim_ties=true) {
  epsilon=.1;

  if (part=="all") {
    difference() {
      union() {
        dbl_curve60_left(radius, surface, "body");
        dbl_curve60_left(radius, surface, "gutter");
      }
      dbl_curve60_left(radius, surface, "hole");
      dbl_curve60_left(radius, surface, "connector");
      dbl_curve60_left(radius, surface, "ties", trim_ties=false);
    }
  } else if (part=="gutter-body") {
    translate([-radius, -straight_length(radius)/2, 0])
      ring(radius, 60, wood_height(), double_gutter() + epsilon);
  } else if (part=="gutter") {
    trim_gutter60() {
      dbl_curve60_left(radius, surface, "gutter-body");
      dbl_curve60_left(radius, surface, "body");
    }
  } else if (part=="connector") {
    translate([-radius,-straight_length(radius)/2,0])
      for(i=[0,1]) rotate([0,0,i*60])
        translate([radius,0,0]) rotate([0,0,i*180])
          dbl_connector(surface=surface, part=part);
  } else {
    translate([-radius,-straight_length(radius)/2,0]) {
      for (i=[1,-1]) {
        nr = radius + i*(wood_width()+double_gutter())/2;
        ns = 2*nr/sqrt(3);
        translate([nr,ns/2,0])
          curve60_left(nr, surface=surface, part=part,
                       trim_ties=trim_ties);
      }
      for(i=[0,1]) rotate([0,0,i*60])
        translate([radius,0,0]) rotate([0,0,i*180])
          dbl_connector(surface=surface, part=part);
    }
  }
}

module dbl_sway60(radius, dir, surface="road-rail", part="all",
                  sway_far=false, offset=0.5, trim_ties=true) {
  if (dir=="right") {
    dbl_sway60_right(radius, surface, part, sway_far, offset, trim_ties);
  } else if (dir=="left") {
    dbl_sway60_left(radius, surface, part, sway_far, offset, trim_ties);
  } else { echo("bad direction", dir); }
}

module dbl_sway60_right(radius, surface="road-rail", part="all",
                        sway_far=false, offset=0.5, trim_ties=true) {
  scale([-1,1,1])
    dbl_sway60_left(radius=radius, surface=surface, part=part,
                    sway_far=sway_far, offset=offset,
                    trim_ties=trim_ties, mirror_connector=true);
}

module dbl_sway60_left(radius, surface="road-rail", part="all",
                       sway_far=false, offset=0.5,
                       trim_ties=true, mirror_connector=false) {
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
      union() {
        dbl_sway60_left(radius, surface, "body", sway_far, offset,
                        mirror_connector=mirror_connector);
        dbl_sway60_left(radius, surface, "gutter", sway_far, offset);
      }
      dbl_sway60_left(radius, surface, "hole", sway_far, offset);
      dbl_sway60_left(radius, surface, "connector", sway_far, offset,
                      mirror_connector=mirror_connector);
      dbl_sway60_left(radius, surface, "ties", sway_far, offset, trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      with_bogus60(radius)
        dbl_sway60_left(radius, surface=surface, part="ties",
                        sway_far=sway_far, offset=offset, trim_ties=false);
      dbl_sway60_left(radius, surface=surface, part="body",
                      sway_far=sway_far, offset=offset);
    }
  } else if (part=="gutter") {
    trim_gutter60() {
      dbl_sway60_left(radius, surface=surface, part="gutter-body",
                      sway_far=sway_far, offset=offset);
      dbl_sway60_left(radius, surface=surface, part="body",
                      sway_far=sway_far, offset=offset);
    }
  } else if (part=="gutter-body") {
    dbl_straight60(radius, surface=surface, part="gutter-body");
  } else if (part=="connector" || part=="body") {
    if (part=="body") {
      dbl_sway60_left(radius, surface, "body-main",
                      sway_far, offset);
    }
    // Bottom connector: dbl if sway_far, else normal
    suppress_body = (part=="body" && !mirror_connector);
    translate([0,-straight_length(radius)/2,0]) {
      if (sway_far) {
        if (!suppress_body)
          dbl_connector(surface=surface, part=part, mirror=mirror_connector);
      } else if (part=="connector") {
        loose_wood_cutout();
      }
    }
    // Top connector
    translate([0,straight_length(radius)/2,0]) rotate([0,0,180])
      if (!suppress_body)
        dbl_connector(surface=surface, part=part, mirror=mirror_connector);
  } else {
    translate([sway_far ? 0 : (-sway_offset/2),stub_offset,0])
      for(i=[-1,1]) rotate([0,0,(i+1)*90])
      translate([sway_offset/2,-(straight_length(radius)/2)+(i*stub_offset),0]) {
      if (part=="body-main") {
        translate([wood_width()/2,0,0])
          rotate([0,0,90]) wood_track(stub_length + (i*stub_offset) + epsilon, false);
        translate([-sway_radius,stub_length + (i*stub_offset),0])
          wood_track_arc(sway_radius - (wood_width()/2), sway_angle + epsilon,
                        false);
      } else if (part=="hole" || part=="ties") {
        do_rails_or_roads(surface=surface, part=part, mirror_symmetric=false) {
          /* rails */
          for (which=["rails","ties"]) {
            which_height = (which=="rails" ? 0 : -well_tie_height());
            difference() {
              with_bogus60(radius) {
                if (part=="hole") {
                  translate([wood_width()/2, -epsilon, which_height])
                    rotate([0,0,90])
                    wood_rails(stub_length + (i*stub_offset) + 2*epsilon, bevel_ends=false);
                  translate([-sway_radius, stub_length + (i*stub_offset), which_height])
                    wood_rails_arc(sway_radius - (wood_width()/2),
                                   sway_angle + epsilon, bevel_ends=false);
                }
                if (part=="ties" && which=="ties") {
                  translate([-wood_width()/2 - sway_offset/2 - epsilon,
                             -epsilon,
                             wood_height() - tie_height()]) {
                    cube([wood_width() + (sway_offset/2) + 2*epsilon,
                          straight_length(radius)/2 +
                          (i*stub_offset) +
                          tie_width()/2 + 2*epsilon,
                          wood_height()]);
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

module dbl_curve_sway60(radius, dir, surface="road-rail", part="all",
                        just_curve=false, far_side=false,
                        trim_ties=true) {
  if (dir=="right") {
    dbl_curve_sway60_right(radius, surface, part, just_curve, far_side,
                           trim_ties);
  } else if (dir=="left") {
    dbl_curve_sway60_left(radius, surface, part, just_curve, far_side,
                          trim_ties);
  } else { echo("bad direction", dir); }
}

module dbl_curve_sway60_right(radius, surface="road-rail", part="all",
                              just_curve=false, far_side=false,
                              trim_ties=true) {
  scale([-1,1,1])
    dbl_curve_sway60_left(radius, surface, part, just_curve, far_side,
                          trim_ties, mirror_connector=true);
}

module dbl_curve_sway60_left(radius, surface="road-rail", part="all",
                             just_curve=false, far_side=false,
                             trim_ties=true, mirror_connector=false) {
  epsilon=.1;
  if (part=="all") {
    difference() {
      union() {
        dbl_curve_sway60_left(radius, surface, "body",
                              just_curve, far_side,
                              mirror_connector=mirror_connector);
        dbl_curve_sway60_left(radius, surface, "gutter",
                              just_curve, far_side,
                              mirror_connector=mirror_connector);
      }
      dbl_curve_sway60_left(radius, surface, "hole",
                            just_curve, far_side);
      dbl_curve_sway60_left(radius, surface, "connector",
                            just_curve, far_side,
                            mirror_connector=mirror_connector);
      dbl_curve_sway60_left(radius, surface, "ties",
                            just_curve, far_side, trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      with_bogus60(radius)
        dbl_curve_sway60_left(radius, surface=surface, part="ties",
                              just_curve=just_curve, far_side=far_side,
                              trim_ties=false);
      dbl_curve_sway60_left(radius, surface=surface, part="body",
                            just_curve=just_curve, far_side=far_side);
    }
  } else if (part=="gutter") {
    trim_gutter60() {
      dbl_curve_sway60_left(radius, surface=surface, part="gutter-body",
                            just_curve=just_curve, far_side=far_side);
      dbl_curve_sway60_left(radius, surface=surface, part="body",
                            just_curve=just_curve, far_side=far_side);
    }
  } else if (part=="gutter-body") {
    dbl_curve60_left(radius, surface=surface, part="gutter-body");
    // Add a bit extra to connect to far_side curve (otherwise there
    // is a small gap, because far_side curve starts with straight segment)
    if (far_side) {
      translate([0,-straight_length(radius)/4,wood_height()/2])
        cube([double_gutter(),straight_length(radius)/2,wood_height()],
             center=true);
    } else {
      // extra for smooth transition on near side curve
      curve60_left(radius, surface, "body");
    }
  } else {
    offset = (wood_width() + double_gutter())/2;
    new_radius = radius - 2*offset;
    far_offset = far_side ? (wood_width() + double_gutter())/sqrt(3) : 0;
    if (part=="connector") {
      rotate([0,0,-120]) translate([0,-straight_length(radius)/2,0])
        loose_wood_cutout();
    }
    if (!just_curve) {
      suppress = (part=="body") && (far_side != mirror_connector);
      translate([0,-straight_length(radius)/2,0]) if (!suppress)
        dbl_connector(surface=surface, part=part, mirror=mirror_connector);
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
      } else if (part=="hole" || part=="ties") {
        do_rails_or_roads(surface=surface, part=part, mirror_symmetric=false) {
          /* rails */
          for (which=["rails","ties"]) {
            which_height = (which=="rails" ? 0 : -well_tie_height());
            difference() {
              with_bogus60(radius) {
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
                angle_increment = tie_angle(arc_radius=radius, basic_radius=radius);
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
                angle_increment = tie_angle(arc_radius=radius, basic_radius=radius)*2;
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

module do_rails_or_roads(surface="road-rail", part="both", mirror_symmetric=true) {
  if (startswith(surface, "rail-")) { children(0); /* rail on top */ }
  if (startswith(surface, "road-")) {
    if (part != "ties") children(1); /* road on top */
  }

  translate([0,0,wood_height()/2])
    rotate([0, mirror_symmetric ? 180 : 0, mirror_symmetric ? 180 : 0])
    scale([1, 1, mirror_symmetric ? 1 : -1])
    translate([0,0,-wood_height()/2]) {
    if (endswith(surface, "-rail")) { children(0); /* rail on bottom */ }
    if (endswith(surface, "-road")) {
      if (part != "ties") children(1); /* road on bottom */
    }
  }
}

module loose_wood_cutout(extra_trim=0, cutout_width=undef) {
  rotate([0,0,90]) wood_cutout();
  // shorten the pieces slightly to make them fit less tightly
  trim=1;//mm
  width = (cutout_width!=undef) ? cutout_width :
    wood_width() + double_gutter() + extra_trim + trim;
  cube([width, trim, 2*wood_height()+trim], center=true);
}

// Based on wood_plug from tracklib.scad, just with the neck shifted over
// to make it deliberately incompat w/ standard plug.  This keeps kids
// from connecting single track to double track.
module dbl_wood_plug(height=wood_height()) {
  neck_length = wood_plug_neck_length();
  post_w = 6.5; // was 6
  bevel_width = 1;
  epsilon = .1;
  neck_offset = wood_plug_radius() - post_w/2 - 0.5; // was 0

  translate([-epsilon,-post_w/2 - neck_offset,0]) hull() {
    translate([0,0,1])
      cube([epsilon+neck_length,post_w,height-2]);
    translate([0,1,0])
      cube([epsilon+neck_length,post_w-2,height]);
  }
  translate([neck_length,0,0]) hull() {
    translate([0,0,1])
      cylinder(h=height-2, r=wood_plug_radius());
    cylinder(h=height, r=wood_plug_radius()-bevel_width);
  }
}

// Based on wood_cutout() from tracklib, but altered like dbl_wood_plug() is
module dbl_wood_cutout(height=wood_height()) {
  radius = wood_plug_radius() + .3;
  post_w = 6.5; // was 6
  neck_width = post_w + 1.5;
  neck_offset = wood_plug_radius() - post_w/2 - 0.5; // was 0
  neck_length = wood_plug_neck_length();
  track_height = height;
  epsilon = .1;
  bevel_width = 1;
  bevel = epsilon + bevel_width;
  bevel_pad = sqrt(.5)*(epsilon/2);
  bevel_height = sqrt(.5)*(bevel_width+epsilon);
  bevel_radius = bevel_height - bevel_pad;
  height_pad = sqrt(.5)*(bevel_width/2);

  union() {
    translate([-epsilon,-neck_width/2 - neck_offset,-epsilon]) {
      cube(size=[epsilon+neck_length,neck_width,track_height+2*epsilon]);
    }
    translate([neck_length,0,track_height/2]) {
      cylinder(h=track_height+2*epsilon,r=radius, center=true);
    }
    // bevelled edges
    translate([neck_length,0,track_height+epsilon-height_pad]) {
      cylinder(h=bevel_height+epsilon,r1=radius-bevel_pad, r2=radius+bevel_radius, center=true);
    }
    translate([neck_length,0,height_pad-epsilon]) {
      cylinder(h=bevel_height+epsilon,r1=radius+bevel_radius,r2=radius-bevel_pad, center=true);
    }
    for (i=[ (neck_width/2)-bevel_pad, -(neck_width/2)+bevel_pad ]) {
      for (j=[ track_height+bevel_pad, -bevel_pad ]) {
        translate([(neck_length-epsilon)/2,i - neck_offset,j]) {
          rotate([45,0,0]) {
            cube([epsilon+neck_length,bevel,bevel], center=true);
          }
        }
      }
    }
  }
}

// adapt traditional brio connector to new dbl_connector
// this just helps me adapt some existing track I'd made; you shouldn't need
// this for new pieces.
module dbl_dogbone(surface="road-rail") {
  offsets = surface_offsets(surface);
  offset_top = offsets[0];
  offset_bottom = offsets[1];
  height = wood_height() - offset_top - offset_bottom;
  epsilon = .1;

  old_post_w = 6;
  new_post_w = 6.5;
  neck_offset = 2.25; // copied from dbl_wood_plug, etc.

  difference() {
    union() {
      translate([(wood_width()+double_gutter())/2,0,0])
        dbl_connector(surface=surface, part="body");
      translate([0,0,offset_bottom]) scale([1,1,height/wood_height()])
        rotate([0,0,90]) wood_plug(true);
    }
    linear_extrude(height=2*wood_height()+epsilon, center=true)
      polygon(points=[
         [-old_post_w/2, 0],
         [-old_post_w/2 - new_post_w, -new_post_w],
         [-old_post_w/2 - new_post_w, 1],
         [-old_post_w/2, 1]
         ]);
    linear_extrude(height=2*wood_height()+epsilon, center=true)
      polygon(points=[
         [new_post_w/2 - neck_offset, 0],
         [new_post_w/2 - neck_offset + old_post_w, old_post_w],
         [new_post_w/2 - neck_offset + old_post_w, -1],
         [new_post_w/2 - neck_offset, -1]
         ]);
  }
}

module dbl_dogbone_plug(surface="road-rail") {
  offsets = surface_offsets(surface);
  offset_top = offsets[0];
  offset_bottom = offsets[1];
  height = wood_height() - offset_top - offset_bottom;
  length = 50; // arbitrary
  epsilon=.1;
  //$fn=8;

  scale([1,1,height/wood_height()])
  difference() {
    difference() {
      translate([-wood_width()/2, 0, 0])
        cube([wood_width(), length, wood_height()]);
      translate([-(wood_width()+double_gutter())/2,0,0])
        dbl_connector(surface="rail-rail", part="connector");
    }
    minkowski() {
      difference() {
        translate([-wood_width()/2, 0, 0])
          cube([wood_width(), length, wood_height()]);
        loose_wood_cutout();
      }
      // subtract some extra clearance
      cylinder(r=0.2, h=5, center=true, $fn=8);
    }
  }
}

module dbl_connector(surface="road-rail", part="all", mirror=false) {
  offsets = surface_offsets(surface);
  offset_top = offsets[0];
  offset_bottom = offsets[1];
  height = wood_height() - offset_top - offset_bottom;

  scale([mirror?-1:1,1,1])
  if (part=="connector") {
    translate([(wood_width() + double_gutter())/2,0,offset_bottom])
      rotate([0,0,90]) dbl_wood_cutout(height=height);
    // extra "looseness", like loose_wood_cutout
    trim = 1;
    difference() {
      translate([0, 0, wood_height()/2])
        cube([2*wood_width() + double_gutter() + trim, trim,
              wood_height()+trim], center=true);
      translate([-(wood_width() + double_gutter())/2, trim, offset_bottom])
        rotate([0,0,-90]) dbl_wood_plug(height=height);
    }
  } else if (part=="body") {
    translate([-(wood_width() + double_gutter())/2,0,offset_bottom])
      rotate([0,0,-90]) dbl_wood_plug(height=height);
  }
}

module pie_centered(radius, angle, height, spin=0) {
  translate([0,0,-height/2]) pie(radius, angle, height, spin=spin);
}

module ring(radius, angle, height, width, spin=0, center=false) {
  epsilon=.1;
  translate([0,0,center?(-height/2):0]) rotate([0,0,spin]) difference() {
    pie(radius + width/2, angle, height);
    translate([-epsilon,0,-epsilon])
      pie(radius - width/2 + epsilon, angle + 2*epsilon, height + 2*epsilon, -epsilon);
  }
}

// a rectangle, tapered at 45 degree angles.  sort of line a cone($fn=4),
// but not just for squares.
module rect45(x, y, h, x_only=false, y_only=false) {
  intersection() {
    if (!y_only) rotate([90,0,0])
      linear_extrude(height=y, center=true)
        polygon(points=[[-x/2,0],[0,x/2],[x/2,0]]);
    if (!x_only) rotate([0,-90,0])
      linear_extrude(height=x, center=true)
        polygon(points=[[0,-y/2],[y/2,0],[0,y/2]]);
    translate([-x/2,-y/2,0])
      cube([x, y, h]);
  }
}

// Idea: dogbone cutout on bottom, built-in dogbone at top
module riser60(part="all", dogbone=true, ncutouts=3) {
  rise = riser_height();
  epsilon = .1;
  length = wood_width(); // allows stacking
  width = wood_width() + 12; // margin for clips
  top_thick = 2;
  top_height = max(11, road_height());
  bumpr=4;
  infringe=0.75;

  if (part=="all") {
    difference() {
      union() {
        riser60(part="top", dogbone=dogbone, ncutouts=ncutouts);
        riser60(part="pillar", dogbone=dogbone, ncutouts=ncutouts);
        riser60(part="base", dogbone=dogbone, ncutouts=ncutouts);
      }
      riser60(part="hole", dogbone=dogbone, ncutouts=ncutouts);
    }
  } else if (part=="top") {
    // top
    difference() {
      translate([-width/2, -length/2, rise-top_thick])
        cube([width, length, top_thick + top_height]);
      difference() {
        innerw = (wood_width()-infringe) + 2*bumpr - 0.5 /* hide points */;
        translate([-innerw/2, -length/2-epsilon, rise])
          cube([innerw, length+2*epsilon, top_height + epsilon]);
        // bumpers
        for (i=[1,-1]) for (j=[1,-1]) scale([i,j,1]) {
          translate([(wood_width()-infringe)/2+bumpr, 8.2, rise + 6])
            rotate([90,0,0]) {
              cylinder(r=bumpr, h=6, center=true, $fn=24);
              for (k=[1,-1]) scale([1,1,k])
                translate([0,0,3-epsilon])
                  cylinder(r1=bumpr, r2=0, h=bumpr);
            }
        }
        // (optional) integral dogbone
        if (dogbone) {
          translate([0,0,rise])
            scale([1,1,road_height()/(wood_height()-bevel())])
              translate([0,0,-bevel()]) {
                rotate([0,0,90]) wood_plug(true);
                rotate([0,0,-90]) wood_plug(true);
              }
        }
      }
    }
  } else if (part=="base") {
    // base
    difference() {
      translate([-width/2,-length/2,0])
        cube([width,length,wood_height()/*allows stacking*/]);
      translate([0,0,wood_height()+epsilon]) scale([1,1,-1])
        rect45(width+epsilon, length-2*top_thick,
               wood_height()+epsilon-top_thick, y_only=true);
    }
  } else if (part=="pillar") {
    // pillars connecting top to bottom
    pillar_thick = 6;
    spacing = dogbone ?
      wood_plug_radius() + wood_plug_neck_length() - pillar_thick/2 + top_thick
      : width/4;
    for (i=[1,-1]) scale([i,1,1])
      translate([spacing, 0, rise/2])
        cube([pillar_thick, length, rise-epsilon], center=true);
     if (dogbone)
       rect45(2*spacing,
              2*(wood_plug_radius() + top_thick + wood_height()),
              wood_height() + top_thick, y_only=true);
  } else if (part=="hole") {
    // decorative grill
    spacing=(rise-2*top_thick)/(3*ncutouts+1);
    for (i=(ncutouts<3||!dogbone)?[2:3:3*ncutouts]:[5:3:3*(ncutouts-1)])
      translate([0,0,i*spacing + top_thick])
        rotate([0,90,0])
          cylinder(r=spacing, h=width, center=true, $fn=4);
    if (ncutouts>2) for (j=[1,-1]) scale([1,j,1]) {
      for (i=(ncutouts<5||!dogbone)?[3.5:3:3*ncutouts]:[6.5:3:3*(ncutouts-1)])
        translate([0,spacing*3/2,i*spacing + top_thick])
          rotate([0,90,0])
            cylinder(r=spacing, h=width, center=true, $fn=4);
      if (ncutouts>3) {
        for (i=[5:3:3*(ncutouts-1)])
          translate([0,spacing*3,i*spacing + top_thick])
            rotate([0,90,0])
              cylinder(r=spacing, h=width, center=true, $fn=4);
      }
    }
    // dogbone cutout
    if (dogbone) intersection() {
      clearance=0.5;
      scale([1,1,(wood_height()+bevel()+clearance)/wood_height()])
        for (i=[0,180]) rotate([0,0,i]) wood_cutout();
      // trim bevels which extend above wood_height()
      translate([-width/2-epsilon,-length/2-epsilon,-epsilon])
        cube([width+2*epsilon, length+2*epsilon,
              wood_height()+clearance+epsilon]);
    }
  }
}

module slope60(radius, surface="road-rail", part="all", trim_ties=true) {
  // symmetric piece, having same thing on both sides makes no sense
  // and we can use a gentler slope (no stub) if one side is blank
  nsurface = (
    surface=="rail-rail" ? "blank-rail" :
    surface=="road-road" ? "road-blank" :
    surface
  );
  epsilon=.1;
  rise=riser_height();
  length=straight_length(radius);
  stub_length = // a stub can help piece sit flat on risers
    (startswith(nsurface, "blank-") || endswith(nsurface, "-blank")) ? 0 :
    wood_width()/3; // cheat a bit: full would be wood_width/2
  slope_length = length - 2*stub_length;
  slope_angle=atan2(rise,slope_length);
  slope_radius=sqrt(pow(rise,2)+pow(slope_length,2))/(4*sin(slope_angle));

  //hypo= sqrt(pow(rise/2,2) + pow(length/2,2));
  //echo(length=length,slope_length=slope_length,slope_angle=slope_angle,slope_radius=slope_radius,hypo=hypo);

  if (part=="all") {
    difference() {
      slope60(radius, nsurface, "body");
      slope60(radius, nsurface, "hole");
      slope60(radius, nsurface, "connector");
      slope60(radius, nsurface, "ties", trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      with_bogus60(radius)
        slope60(radius, surface=nsurface, part="ties", trim_ties=false);
      slope60(radius, surface=nsurface, part="body");
    }
  } else {
    for(i=[-1,1]) rotate([0,0,(i+1)*90]) {
      if (part=="body") {
        difference() {
          union() {
            translate([-wood_width()/2,-slope_length/2,i*(rise/2)])
              wood_track_slope(slope_radius + wood_height()/2,
                               -i*(2*slope_angle + epsilon),
                               rails=false);
            if (stub_length>0)
              translate([wood_width()/2,-length/2,i*(rise/2)])
                rotate([0,0,90]) wood_track(stub_length+epsilon, false);
          }
          // flatten concave side so it sits properly on riser
          if ((i>0)?
              (!startswith(nsurface, "blank-")) :
              (!endswith(nsurface, "-blank"))) {
            translate([0,-length/2,(i>0?0:wood_height())])
              cube([wood_width()+epsilon, wood_width()+1/*clearance*/, rise],
                    center=true);
          }
        }
      } else if (part=="connector") {
        translate([0, -length/2, i*(rise/2) + wood_height()/2])
          /* scale cutout in z direction to account for track curvature */
          scale([1,1,2]) translate([0,0,-wood_height()/2])
            loose_wood_cutout();
      } else if (part=="hole" || part=="ties") {
        do_rails_or_roads(surface=nsurface, part=part) {
          /* rails */
          for (which=["rails","ties"]) {
            which_height = (which=="rails" ? 0 : -well_tie_height());
            difference() {
              with_bogus60(radius) {
                if (part=="hole") {
                  translate([-wood_width()/2, -slope_length/2,
                             i*(rise/2) + which_height])
                    wood_rails_slope(slope_radius + wood_height()/2 +
                                     i*which_height,
                                     -i*(2*slope_angle + epsilon),
                                     bevel_ends=false);
                  if (stub_length>0)
                    translate([wood_width()/2,-length/2,i*(rise/2) + which_height])
                      rotate([0,0,90]) wood_rails(stub_length+epsilon, false);
                }
                if (part=="ties" && which=="ties") {
                  translate([-wood_width()/2, -slope_length/2,
                             i*(rise/2) + wood_height() - tie_height()])
                    wood_track_slope(slope_radius + wood_height()/2 +
                                     i*(wood_height() - tie_height()),
                                     -i*(2*slope_angle + epsilon),
                                     rails=false);
                  if (stub_length>0)
                    translate([wood_width()/2,-length/2,i*(rise/2) + wood_height() - tie_height()])
                      rotate([0,0,90]) wood_track(stub_length+epsilon, false);
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
                scale([which_width/wood_width(),1,1]) {
                  translate([-wood_width()/2, -slope_length/2,
                             i*(rise/2) + which_height])
                    wood_track_slope(slope_radius + wood_height()/2 +
                                     i*which_height,
                                     -i*(2*slope_angle + epsilon),
                                     rails=false);
                  if (stub_length>0)
                    translate([wood_width()/2,-length/2,i*(rise/2) + which_height])
                      rotate([0,0,90]) wood_track(stub_length+epsilon, false);
                }
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

// Use a special dogbone joiner to connect to barn piece, since the
// connector kept breaking off when I printed this as one piece.
module barn60(radius, surface="road-rail", part="all", trim_ties=true,
              double_sided=false) {
  barn_width = 204;
  driveway_width = 46.6;

  if (part=="all") {
    difference() {
      barn60(radius, surface, "body");
      barn60(radius, surface, "hole", double_sided=double_sided);
      barn60(radius, surface, "connector");
      barn60(radius, surface, "ties", trim_ties=false);
    }
  } else if (part=="dogbone") {
    difference() {
      translate([wood_width()/2,0,0])
        track60_demo(part="dogbone", r=radius);
      barn60(radius, surface, "hole-door");
      straight60(radius, surface=surface, part="hole");
    }
  } else if (part=="hole-door") {
    translate([0,-driveway_width/2, road_height()])
      cube([wood_width(), driveway_width, wood_height()]);
    translate([0,0,wood_height()/2]) for (j=[1,-1]) scale([1,1,j])
    translate([wood_width()/2 + 3.8 + 0.5, -driveway_width/2, 7.4 - wood_height()/2])
      cube([8, driveway_width, wood_height()]);
  } else {
    straight60(radius, surface=surface, part=part, trim_ties=trim_ties);
    if (part=="hole") {
      for (i=(double_sided?[1,-1]:[1])) scale([i,1,1]) {
        barn60(radius, surface, part="hole-door");
        // space for dogbone
        translate([wood_width()/2,0,0])
          rotate([0,0,90]) loose_wood_cutout(cutout_width=barn_width);
      }
    }
  }
}

function track60_radius_for(x, y) = (x*x + y*y)/(2*y);
function track60_angle_for(x, y) = atan2(x, track60_radius_for(x,y)-y);

module firehouse60(radius, surface="road-rail", part="all", mirrored=false, trim_ties=true) {
  // narrowing double track.
  firehouse_length = 6 /*inches*/ * 25.4;
  firehouse_width = 5.875 /* inches */ * 25.4;
  firehouse_spacing = 62.5; // space between tracks
  desired_spacing = wood_width() + double_gutter();
  max_spacing = max(firehouse_spacing, desired_spacing);
  epsilon = .1;

  firehouse_units = 2; //  how many "straight pieces" should this take up.
  transition_length = (firehouse_units*straight_length(radius) - firehouse_length) / 2;
  transition_x = transition_length/2;
  transition_y = (firehouse_spacing - desired_spacing)/4;
  transition_radius = track60_radius_for(transition_x, transition_y);
  transition_angle = track60_angle_for(transition_x, transition_y);

  // increase circle res since radius is high/angle is small
  myfn=ceil(360/transition_angle)*8;

  if (part=="all" && !mirrored) {
    difference() {
      union() {
        firehouse60(radius, surface, "body");
        firehouse60(radius, surface, "gutter");
      }
      firehouse60(radius, surface, "hole");
      firehouse60(radius, surface, "connector");
      firehouse60(radius, surface, "ties", trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      with_bogus60(radius)
        firehouse60(radius, surface, part, mirrored=mirrored, trim_ties=false);
      firehouse60(radius, surface, part="body", mirrored=mirrored);
    }
  } else if (part=="gutter") {
    trim_gutter60() {
      firehouse60(radius, surface, part="gutter-body", mirrored=mirrored);
      firehouse60(radius, surface, part="body", mirrored=mirrored);
    }
  } else if (part=="gutter-body") {
    translate([0,transition_length/2,wood_height()/2])
      cube([max_spacing + epsilon, transition_length, wood_height()],
           center=true);
    scale([firehouse_width/2, transition_length/2, 1])
      pie(1, 180, wood_height());
  } else if (part=="connector" || part=="body-extra") {
    // double track connector
    translate([0,transition_length,0]) rotate([0,0,180])
      dbl_connector(surface=surface,
                    part=(part=="body-extra"?"body":part));
    // connections to firehouse
    if (part=="connector") {
      for (i=[1,-1]) scale([i,1,1]) translate([firehouse_spacing/2,0,0])
        loose_wood_cutout(extra_trim=firehouse_width);
    }
  } else if (!mirrored) {
    if (part=="body") { firehouse60(radius, surface, "body-extra"); }
    for  (i=[-1,1]) scale([i,1,1]) {
      translate([firehouse_spacing/2,0,0]) intersection() {
        firehouse60(radius, surface, part,
                    mirrored=true, trim_ties=false);
        translate([-transition_radius,0,0])
          pie_centered(transition_radius + wood_width(),
                       transition_angle + epsilon, wood_height()*3);
      }
      translate([desired_spacing/2,transition_length,0]) rotate([0,0,180]) intersection() {
        firehouse60(radius, surface, part,
                    mirrored=true, trim_ties=false);
        translate([-transition_radius,0,0])
          pie_centered(transition_radius + wood_width(),
                       transition_angle + epsilon, wood_height()*3);
      }
    }
  } else if (part=="body") {
    translate([-transition_radius,0,0])
      wood_track_arc(transition_radius - (wood_width()/2),
                     transition_angle + epsilon, false, $fn=myfn);
  } else if (part=="hole" || part=="ties") {
    translate([-transition_radius,0,0])
    do_rails_or_roads(surface=surface, part=part, mirror_symmetric=false){
      /* rails */
      wood_rails_and_ties_arc(transition_radius,
                              angle=transition_angle+epsilon,
                              part=(part=="hole"?"rails":part),
                              basic_radius=radius,
                              ties_from_end=true, $fn=myfn);
      /* roads */
      wood_road_and_stripes_arc(transition_radius,
                                angle=transition_angle+epsilon,
                                basic_radius=radius,
                                stripes_from_end=true, $fn=myfn);
    }
  }
}

module carwash60(radius, surface="road-rail", part="all", trim_ties=true) {
  carwash_length = 138; // "entrance to exit" distance
  carwash_connector_sep = 125.5; // between connectors on the entrance side
  carwash_width = 73.5*2 + 52.5;
  epsilon = .1;

  if (part=="all") {
    difference() {
      carwash60(radius, surface, "body");
      carwash60(radius, surface, "hole");
      carwash60(radius, surface, "connector");
      carwash60(radius, surface, "ties", trim_ties=false);
    }
  } else if (part=="carwash") {
    translate([-radius, straight_length(radius)/2-carwash_length, -1])
      cube([radius*2, radius, wood_height() + 2]);
  } else if (part=="body") {
    difference() {
      straight60(radius, surface=surface, part=part, trim_ties=trim_ties);
      carwash60(radius, surface=surface, part="carwash");
    }
    difference() {
      if (true) {
        union() { for (i=[-1,1]) scale([i,1,1]) {
          translate([wood_width()/2,
                     straight_length(radius)/2 - carwash_length, 0])
            scale([(carwash_width-wood_width())/2,
                   straight_length(radius)-carwash_length, 1])
              cylinder(r=1, h=wood_height());
        } }
      } else {
        translate([-carwash_width/2, -straight_length(radius)/2, 0])
          cube([carwash_width, straight_length(radius), wood_height()]);
      }
      carwash60(radius, surface=surface, part="carwash");
      cube([wood_width()-epsilon,2*radius, 2*wood_height()], center=true);
      for (i=[-1,1])
        translate([0,0,wood_height()/2]) scale([1,1,i])
        translate([0,0,wood_well_height()])
        cube([wood_width() + double_gutter(), 2*radius, wood_height()],
             center=true);
    }
    for (j=[-1,1]) scale([j,1,1]) {
      translate([carwash_connector_sep/2,
                 straight_length(radius)/2 - carwash_length, 0])
        rotate([0,0,90]) wood_plug();
    }
  } else {
    straight60(radius, surface=surface, part=part, trim_ties=trim_ties);
  }
}

// XXX Consider overlaying piece on two point-to-point triangles, instead of
// two flat-to-flat triangles.  In/out entrances would come from straights,
// and the side entrance/exit would arc 30 degree from top or bottom slant.
// Takes up more space that way, though.
module recycling60(radius, dir="left", surface="road-rail", split_surface=false, part="all", trim_ties=true) {
  hexr=radius/1.5;
  straight_length = straight_length(radius);
  recycling_width = straight_length + 25;
  recycling_length = 135;
  side_connector_offset = 10.5;
  inout_spacing = 136.5;
  cheat_down = 8;

  // part one is a sway from `sway_dest` to `sway_hex`:
  sway_dest = [recycling_width/2,
               (recycling_length-straight_length)/2
               - side_connector_offset - cheat_down];
  sway_hex = [straight_length, 0];
  sway_x = sway_hex.x - sway_dest.x;
  sway_y = sway_hex.y - sway_dest.y;
  sway_r = track60_radius_for(sway_x/2, sway_y/2);
  sway_a = track60_angle_for(sway_x/2, sway_y/2);

  // part two is a 30 degree arc(-ish) from `arc_dest` to `arc_hex`:
  arc_dest = [inout_spacing/2,
              recycling_length - (straight_length/2) - cheat_down];
  arc_hex = [straight_length/4, (3/4)*hexr];
  arc_x = arc_dest.x - arc_hex.x;
  arc_y = arc_hex.y - arc_dest.y;
  arc_r = 2*arc_y; // 30-60-90 triangle
  // However, a pure arc won't line up.  We need a bit of sway.
  // The top will sway away 'alpha' degrees, and then we'll sway back
  // 'alpha + 30' degrees to enter the recycling center.
  // I gave up doing the algebra to determine exactly how much sway is
  // needed, instead I just manually set a y amount (`y_adj`) for the first
  // 30 degree arc, rotated the remaining x and y amounts by 30 degrees,
  // and computed the remaining sway needed.  I adjusted the y amount
  // until the radii of the first arc and the sway match, in order
  // to have a seamless transition.
  // for cheat_down = 10, y_adj = 19.244
  // for cheat_down = 8,  y_adj = 17.543
  // for cheat_down = 5,  y_adj = 15.203
  y_adj = 17.543; // trial and error to get first_r and arc_sway_r to match
  first_r = y_adj*2;
  first_x = first_r*(1-sqrt(3)/2);
  new_x = (arc_x - first_x);
  new_y = (arc_y - y_adj);
  rot_x = new_x*cos(30) - new_y*sin(30);
  rot_y = new_x*sin(30) + new_y*cos(30);
  arc_sway_r = track60_radius_for(rot_y/2, rot_x/2);
  arc_sway_a = track60_angle_for(rot_y/2, rot_x/2);
  //echo(first_r=first_r, arc_sway_r = arc_sway_r);

  epsilon = .1;
  myfn=96;

  if (part=="all") {
    difference() {
      union() {
        recycling60(radius, dir, surface, split_surface, "body");
        recycling60(radius, dir, surface, split_surface, "gutter");
      }
      recycling60(radius, dir, surface, split_surface, "hole");
      recycling60(radius, dir, surface, split_surface, "connector");
      recycling60(radius, dir, surface, split_surface, "ties", trim_ties=false);
    }
  } else if (dir=="left") {
    scale([-1,1,1])
      recycling60(radius, "right", surface, split_surface, part, trim_ties);
  } else if (startswith(part, "recycling")) {
    is_hole = (part=="recycling-hole");
    trim = is_hole ? 1 : 0; // matches loose_wood_cutout
    translate([0, -straight_length/2 + recycling_length/2 - cheat_down, 0]) {
      difference() {
        union() {
          translate([0,0,wood_height()/2])
            cube([recycling_width + trim, recycling_length + trim,
                  wood_height() + trim], center=true);
          if (is_hole)
            translate([0,-radius, 0])
              cube([recycling_width + trim, 2*radius, 2*wood_height()],
                   center=true);
        }
        if (!is_hole) {
          for (i=[1,-1]) scale([i,1,1]) {
            translate([recycling_width/2, 0, 0])
              rotate([0,0,180]) wood_cutout();
            translate([inout_spacing/2, recycling_length/2, 0])
              rotate([0,0,-90]) wood_cutout();
          }
        }
      }
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      with_bogus60(radius)
        recycling60(radius, dir, surface, split_surface, part, trim_ties=false);
      recycling60(radius, dir, surface, split_surface, part="body");
    }
  } else if (part=="gutter") {
    border=10;

    road_offset = wood_height() - road_height();
    rail_offset = road_offset; // looks better than wood_well_height()
    top_offset =
     startswith(surface, "road-") ? road_offset :
     startswith(surface, "rail-") ? rail_offset : 0;
    bottom_offset =
     endswith(surface, "-road") ? road_offset :
     endswith(surface, "-rail") ? rail_offset : 0;
    height = wood_height() - top_offset - bottom_offset;

    intersection() {
      pie_center=[0,(recycling_length-straight_length)/2 + border/2,0];
      pie_scale =[recycling_width/recycling_length,1,1];
      main_radius = sqrt(2)*(recycling_length/2) + border/2;
      union() {
        translate(pie_center+[0,0,bottom_offset]) scale(pie_scale)
          pie(main_radius, 180, height, spin=-90);
        if (height < wood_height()) difference() {
          translate(pie_center) scale(pie_scale)
            pie(main_radius + epsilon, 180, wood_height(), spin=-90);
          minkowski() {
            sphere(r=2, $fn=6);
            recycling60(radius, dir, surface, split_surface, part="body");
          }
        }
      }
      difference() {
        translate([straight_length/2,0,0]) rotate([0,0,30])
          cylinder(r=hexr - 0.5/*trim*/, h=3*wood_height(), center=true, $fn=6);
        recycling60(radius, dir, surface, split_surface, part="recycling-hole");
      }
    }
  } else if (part=="body" || part=="hole" || part=="ties" || part=="connector") {

    // optionally flip the surface for the arc piece
    arc_surface = split_surface ? flip_surface(surface) : surface;
    recycling60(radius, dir, surface, false, str(part, "-sway"));
    recycling60(radius, dir, arc_surface, false, str(part, "-inout"));
  } else if (endswith(part, "-sway")) {
    npart = str(part, "-mirrored");
    translate(sway_hex) rotate([0,0,90]) intersection() {
      with_bogus60(radius, disable=startswith(part, "body-"))
      recycling60(radius, dir, surface, false, npart, trim_ties=false);
      translate([-sway_r,0,0])
        pie_centered(sway_r + wood_width(),
                     sway_a + epsilon, wood_height()*3);
    }
    translate(sway_dest)
      rotate([0,0,-90]) intersection() {
        with_bogus60(radius, disable=startswith(part, "body-"))
        recycling60(radius, dir, surface, false, npart, trim_ties=false);
        translate([-sway_r,0,0])
          pie_centered(sway_r + wood_width(),
                       sway_a + epsilon, wood_height()*3);
    }
  } else if (endswith(part, "-inout")) {
    is_connector = startswith(part, "connector-");
    part_small = str(part, "-small");
    part_big = str(part, "-big");
    translate(arc_hex) rotate([0,0,180+30]) intersection() {
        with_bogus60(radius, disable=startswith(part, "body-"))
          recycling60(radius, dir, surface, false, part_small, trim_ties=false);
        if (!is_connector) translate([-arc_sway_r,0,0])
          pie_centered(arc_sway_r + wood_width(),
                       arc_sway_a + epsilon, wood_height()*3);
    }
    translate(arc_dest) intersection() {
      with_bogus60(radius, disable=startswith(part, "body-"))
        recycling60(radius, dir, surface, false, part_big, trim_ties=false);
      if (!is_connector) translate([-arc_sway_r,0,0])
        pie_centered(arc_sway_r + wood_width(),
                     arc_sway_a + 30 + epsilon, wood_height()*3);
    }
  } else if (startswith(part, "body-inout-")) {
    angle = arc_sway_a + (endswith(part, "-small") ? 0 : 30);
    translate([-arc_sway_r,0,0])
      wood_track_arc(arc_sway_r - (wood_width()/2), angle, false, $fn=myfn);
  } else if (startswith(part, "hole-inout-") ||
             startswith(part, "ties-inout-")) {
    base = split(part, "-")[0];
    angle = arc_sway_a + (endswith(part, "-small") ? 0 : 30);
    translate([-arc_sway_r,0,0])
    do_rails_or_roads(surface=surface, part=part, mirror_symmetric=false) {
      /* rails */
      wood_rails_and_ties_arc(arc_sway_r, angle=angle+epsilon,
                              part=(base=="hole"?"rails":base),
                              basic_radius=radius,
                              ties_from_end=true, $fn=myfn);
      /* roads */
      wood_road_and_stripes_arc(arc_sway_r, angle=angle+epsilon,
                                basic_radius=radius,
                                stripes_from_end=true, $fn=myfn);
    }
  } else if (part=="body-sway-mirrored") {
    translate([-sway_r,0,0])
      wood_track_arc(sway_r - (wood_width()/2),
                     sway_a + epsilon, false, $fn=myfn);
  } else if (part=="hole-sway-mirrored" || part=="ties-sway-mirrored") {
    base = split(part, "-")[0];
    translate([-sway_r,0,0])
    do_rails_or_roads(surface=surface, part=part, mirror_symmetric=false) {
      /* rails */
      wood_rails_and_ties_arc(sway_r, angle=sway_a+epsilon,
                              part=(base=="hole"?"rails":base),
                              basic_radius=radius,
                              ties_from_end=true, $fn=myfn);
      /* roads */
      wood_road_and_stripes_arc(sway_r, angle=sway_a+epsilon,
                                basic_radius=radius,
                                stripes_from_end=true, $fn=myfn);
    }
  } else if (part=="connector-sway-mirrored") {
    loose_wood_cutout(cutout_width=recycling_length);
  } else if (startswith(part, "connector-inout-")) {
    loose_wood_cutout(cutout_width=(recycling_width-inout_spacing));
  }
}

module grade_crossing360(radius, part="all", is_intersection=false) {
  if (part=="all") {
    difference() {
      grade_crossing360(radius, "body");
      grade_crossing360(radius, "hole");
      grade_crossing360(radius, "connector");
      difference() {
        with_bogus60(radius)
          grade_crossing360(radius, "ties");
        grade_crossing360(radius, "body", is_intersection=true);
      }
    }
  } else {
    union_or_intersection(is_intersection=is_intersection) {
      difference() {
        straight60(radius, "road-road", part);
        if (part=="hole") intersection() {
          cube([wood_well_spacing(), straight_length(radius),
                3*wood_height()], center=true);
          rotate([0,0,60])
            cube([wood_well_spacing(), straight_length(radius),
                  3*wood_height()], center=true);
        }
      }
      rotate([0,0,60])
        straight60(radius, "rail-rail", part);
    }
  }
}

module grade_crossing60(radius, part="all", trim_ties=true) {

  if (part=="all") {
    difference() {
      grade_crossing60(radius, part="body");
      grade_crossing60(radius, part="hole");
      grade_crossing60(radius, part="connector");
      grade_crossing60(radius, part="ties", trim_ties=false);
    }
  } else {
    straight60(radius, surface="rail-blank", part=part, trim_ties=trim_ties);
    if (part=="body") {
      for (i=[1,-1]) scale([i,1,wood_height()/road_height()]) {
        translate([wood_width()/2 - 0.5,0,0])
          rotate([0,0,-90])
          translate([0,straight_length(radius)/2,0])
          buffer_or_ramp60(radius, surface="road-blank", which="ramp");
      }
    }
  }
}

module thomas_crossing60(radius, surface="road-rail", part="all", trim_ties=true) {
  thomas_length = 152;
  thomas_width = 120;
  adapter_length = straight_length(radius) - thomas_length;

  if (part=="all") {
    difference() {
      union() {
        thomas_crossing60(radius, surface, "body");
        thomas_crossing60(radius, surface, "gutter");
      }
      thomas_crossing60(radius, surface, "hole");
      thomas_crossing60(radius, surface, "connector");
      thomas_crossing60(radius, surface, "ties", trim_ties=false);
    }
  } else if (part=="ties" && trim_ties) {
    intersection() {
      with_bogus60(radius)
        thomas_crossing60(radius, surface, part, trim_ties=false);
      thomas_crossing60(radius, surface, part="body");
    }
  } else if (part=="gutter") {
    trim_gutter60() {
      thomas_crossing60(radius, surface, part="gutter-body");
      thomas_crossing60(radius, surface, part="body");
    }
  } else if (part=="gutter-body") {
    translate([0,-straight_length(radius)/2,0])
      scale([(thomas_width/2)/adapter_length,1,1])
      pie(adapter_length, 180, wood_height(), spin=0);
  } else if (part=="connector") {
    translate([0,-straight_length(radius)/2,0])
      loose_wood_cutout();
  } else if (part=="body") {
    newr = adapter_length*sqrt(3)/2;
    translate([0,-straight_length(radius)/2 + adapter_length/2,0])
      straight60(newr, surface=surface, part=part, trim_ties=trim_ties);
    // add plug
    translate([0,-straight_length(radius)/2 + adapter_length,0])
      rotate([0,0,90]) wood_plug(true);
  } else {
    // hole and ties unscaled to preserve consistent spacing
    straight60(radius, surface=surface, part=part);
  }
}
