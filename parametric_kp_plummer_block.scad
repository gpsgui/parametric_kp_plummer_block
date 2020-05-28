/*
Author :    Guilherme Pontes (gpsgui)
github :    www.github.com/gpsgui

Release Notes

08/05/2020 -> Version 1.0.0
        Features:
            - 9 possibles presets(kp08 to kp007) of Zinc-die cast kp-series
            - Custom mode, generate a plummer block with arbitrary dimensions 
            - All holes with countersink or counterbore
*/


/* [Hidden] */
$fn = 64;
// presets based on the catalog of zinc-die cast kp-series of Kugellager https://www.kugellager-express.de/silver-series-miniature-plummer-block-housing-unit-kp08-shaft-8-mm
// presets with parameters [ d, h, a, e, b, s, g, w, L, n, ds]
kp08  = [8, 15, 55, 42, 13, 4.8, 5, 29, 11.5, 3.5, "M4"] ;
kp000 = [10, 18, 67, 53, 16, 7, 6, 35, 14, 4, "M6"]; 
kp001 = [12, 19, 71, 56, 16, 7, 6, 38, 14.5, 4, "M6"];
kp002 = [15, 22, 80, 63, 16, 7, 7, 43, 16.5, 4.5, "M6"]; 
kp003 = [17, 24, 85, 67, 18, 7, 7, 47, 17.5, 5, "M6"];
kp004 = [20, 28, 100, 80, 20, 10, 9, 55, 21, 6, "M8"];
kp005 = [25, 32, 112, 90, 20, 10, 10, 62, 22.5, 6, "M8"]; 
kp006 = [30, 36, 132, 106, 26, 11, 11, 70, 24.5, 6.5, "M10"]; 
kp007 = [35, 40, 150, 118, 26, 13, 13, 80, 29.5, 7, "M10"];
presets = [[], kp08, kp000, kp001, kp002, kp003, kp004, kp005, kp006, kp007];
/* [Select KP support preset] */
// If don't want to use a preset, choose "custom"
preset = 0; // [0:custom, 1:kp08, 2:kp000, 3:kp001, 4:kp002, 5:kp003, 6:kp004, 7:kp005, 8:kp006, 9:kp007]
/* [Custom dimensions] */
// shaft diameter
d = 8;    
// heigth of the shaft
h = 15;
// total width of the block
a = 55;
// total height
W = 29;
// base tickness
g = 5;
// distance between bolts
e = 42;
// thickness of support
b = 13;
// locking bolts hole diameter
s = 4.8;
// Bold metric size
ds = "M4";
// half the bearing thickness
n = 3.5;
// size of the bearing clamping boss
L = 11.5;

/* [Finishing] */
// clearance
clearance = 0.1;
//bolt counterbore shape
bolt_counterbore_shape = "conical"; // [none, conical, hex, cylindrical]
// -------------------------------------------------------------------

// shaft diameter
this_d = preset != 0 ? presets[preset][0] : d;   
// heigth of the shaft
this_h = preset != 0? presets[preset][1] : h;
// total width of the block
this_a = preset != 0 ? presets[preset][2] : a;
// distance between bolts
this_e = preset != 0 ? presets[preset][3] : e;
// thickness of support
this_b = preset != 0 ? presets[preset][4] : b;
// locking bolts hole diameter
this_s = preset != 0 ? presets[preset][5] : s;
// base tickness
this_g = preset != 0 ? presets[preset][6] : g;
// total height
this_W = preset != 0 ? presets[preset][7] : W;
// size of the bearing clamping boss
this_L = preset != 0 ? presets[preset][8] : L;
// half the bearing thickness
this_n = preset != 0 ? presets[preset][9] : n;
// Bolt metric size
this_ds = preset != 0 ? ord(presets[preset][10][1]) - ord("0") : ord(ds[1]) - ord("0");

difference(){
    union(){
        translate([0, 0, this_g/2]) 
            cube([this_a, this_b, this_g], center = true);
        translate([0, 0, this_W/2]) 
            rotate([90,0,0]) 
                cylinder(r = this_W/2, h = this_b, center = true); 
    }
    // bearing seat
    translate([0, 0, this_W/2]) 
        rotate([90,0,0]) 
            cylinder(r = this_W/3, h = this_b, center = true);
    
    // Bolt holes
    translate([this_e/2, 0, this_g/2]) 
        cylinder(r = this_s/2, h = this_g, center = true);
    translate([-this_e/2, 0, this_g/2]) 
        cylinder(r = this_s/2, h = this_g, center = true);
    
    // Bolt counterbore
    if(bolt_counterbore_shape == "conical"){
        translate([this_e/2,0,this_g-0.25*this_ds]) 
            cylinder(r1= 0.5*this_ds,r2 = this_ds, h = 0.5*this_ds, center = true);
        translate([-this_e/2,0,this_g-0.25*this_ds]) 
            cylinder(r1= 0.5*this_ds,r2 = this_ds, h = 0.5*this_ds, center = true);
    } else if( bolt_counterbore_shape == "cylindrical"){
        translate([this_e/2,0,this_g - 0.25*this_ds]) 
            cylinder(r = this_ds, h = 0.5*this_ds, center = true);
        translate([-this_e/2,0,this_g - 0.25*this_ds]) 
            cylinder(r = this_ds, h = 0.5*this_ds, center = true);
    } else if( bolt_counterbore_shape == "hex") {
        
    }
    
}