/*
Author :    Guilherme Pontes (gpsgui)
github :    www.github.com/gpsgui

Release Notes

08/05/2020 -> Version 1.0.0
        Features:
            - 10 possibles presets(sk8 to sk40) of SAMICK-like SK shaft supports
            - Custom mode, generate a suport with arbitrary dimensions 
            - All holes with countersink or counterbore
            - Clamping with bolt and nut (with nut housing)
*/


/* [Hidden] */
$fn = 64;
// presets based on the catalog of zinc-die cast kp-series of Kugellager https://www.kugellager-express.de/silver-series-miniature-plummer-block-housing-unit-kp08-shaft-8-mm
// presets with parameters [ d, h, A, W, H, T, E, D, C, B, S, J ]
sk8  = [8, 20, 21, 42, 32.8, 6, 18, 5, 32, 14, 5.5, 4] ;
sk10 = [10, 20, 21, 42, 32.8, 6, 18, 5, 32, 14, 5.5, 4]; 
sk12 = [12, 23, 21, 42, 38, 6, 20, 5, 32, 14, 5.5, 4];
sk13 = [13, 23, 21, 42, 38, 6, 20, 5, 32, 14, 5.5, 4]; 
sk16 = [16, 27, 24, 48, 44, 8, 25, 5, 38, 16, 5.5, 4];
sk20 = [20, 31, 30, 60, 51, 10, 30, 7.5, 45, 20, 6.6, 5];
sk25 = [25, 35, 35, 70, 60, 12, 38, 7, 56, 24, 6.6, 6]; 
sk30 = [30, 42, 42, 84, 70, 12, 44, 10, 64, 28, 9, 6]; 
sk35 = [35, 50, 49, 98, 85, 15, 50, 12, 74, 32, 11, 8];
sk40 = [40, 60, 57, 114, 96, 15, 60, 12, 90, 36, 11, 8];
presets = [[], sk8, sk10, sk12, sk13, sk16, sk20, sk25, sk30, sk35, sk40];
/* [Select SK support preset] */
// If don't want to use a preset, choose "custom"
preset = 0; // [0:custom, 1:sk08, 2:sk10, 3:sk12, 4:sk13, 5:sk16, 6:sk20, 7:sk25, 8:sk30, 9:sk35, 10:sk40]
echo(preset);
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
// Grub Screw metric size
J = 4;
// half the bearing thickness
n = 3.5;
// size of the bearing clamping boss
L = 11.5;

/* [Finishing] */
// clearance
clearance = 0.1;
//bolt counterbore shape
bolt_counterbore_shape = "conical"; // [conical, hex, cylindrical]

difference(){
    union(){
        translate([0,0,g/2])cube([a,b,g], center = true);
        translate([0, 0, h])rotate([90,0,0]) cylinder(r = W/2, h = b, center = true); 
    }
    
}