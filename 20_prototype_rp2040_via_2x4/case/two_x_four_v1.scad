/* material:

plexi x mm:
plexi y mm:
board x mm:

/*

    https://github.com/CrazyRobMiles/PICO-Chord-keyboard


        linear_extrude(height = 2, center = true, convexity = 10)
        translate([0,0,0])
*/
/*
scale(0.35)
translate([-10,-370,0])
import(file = "back_2.dxf");
*/

/*
$fn=12;
translate([-10,10,0])
translate([-3,3,0])
mirror([1,0,0])
projection(cut = false)
import(file = "caseTop.stl");

d1 = 30;
translate([-147.5+59.5,28.5+92.5,0])
square([52-d1,22-d1],true);
translate([-147.5,28.5,0])
square([14.5-d1,14.5-d1],true);
translate([-147.5+27,28.5,0])
square([14.5-d1,14.5-d1],true);
translate([-147.5+46,28.5+56.5,0])
square([14.5-d1,14.5-d1],true);
translate([-147.5+69,28.5+64,0])
square([14.5-d1,14.5-d1],true);
translate([-147.5+92,28.5+58,0])
square([14.5-d1,14.5-d1],true);
translate([-147.5+119,28.5+49,0])
square([14.5-d1,14.5-d1],true);
*/


translate([0,0,0])
square([10,10],true);

$fn=60;
c=5;
d=0;

translate([20,0,0])
// base
difference() {
    base(120,120);
    translate([0,c,0])
    translate([60,45,0])
    square([84,54],true);
}

translate([-20,0,0])
// distance
difference() {
    circle(10);
    circle(4.1);
}

translate([-45,0,0])
// distance
difference() {
    square([24,24],true);
    square([14,14],true);
}



translate([160,0,0])
// plate
difference() {
    //https://golem.hu/guide/concept-to-reality/
    //Cherry MX Basic
    //14 x 14 mm
    base(120,120);
    //translate([60,45,0])
    //square([14,14],true);
    translate([0,d,0])
    for (i = [-30, -10, 10, 30]) {
        for (j = [-10, 10]) {
            translate([60+i,45+j,0])
            square([14,14],true);
        }
    } 
}




/*

// layer 1
d2 = 0;
translate([190*0+10,10,0])
difference() {
    base(155+20,130);
    //translate([-10,10,0])
    //translate([-3,3,0])
    translate([180,-13,0]) {
        translate([-147.5+59.5,28.5+92.5,0])
        square([52-d2,22-d2],true);
        //loetung
        translate([-147.5+59.5-10,28.5+92.5+12,0])
        square([10,3],true);
        translate([-147.5+59.5+10,28.5+92.5-12,0])
        square([10,3],true);        
        translate([-147.5,28.5,0])
        square([14.5-d2,14.5-d2],true);
        translate([-147.5+27,28.5,0])
        square([14.5-d2,14.5-d2],true);
        translate([-147.5+46,28.5+56.5,0])
        square([14.5-d2,14.5-d2],true);
        translate([-147.5+69,28.5+64,0])
        square([14.5-d2,14.5-d2],true);
        translate([-147.5+92,28.5+58,0])
        square([14.5-d2,14.5-d2],true);
        translate([-147.5+119,28.5+49,0])
        square([14.5-d2,14.5-d2],true);
    }
}

//layer 2
d3 = 19;
d4 = 21;
d5 = 1;
d6 = 2;
translate([190*1+10,10,0])
difference() {
    base(155+20,130);
    //translate([-10,10,0])
    //translate([-3,3,0])
    translate([180,-13,0]) {
        //loetung
        translate([-147.5,28.5+65+45,0])
        square([15,20],true);
        translate([-147.5-10,28.5+65,0])
        square([5,50],true);
        translate([-147.5+10,28.5+65,0])
        square([5,50],true);
        translate([-147.5+59.5,28.5+92.5,0])
        square([52+d5,22+d6],true);
        translate([-147.5,28.5,0])
        square([d3, d4],true);
        translate([-147.5+27,28.5,0])
        square([d3, d4],true);
        translate([-147.5+46,28.5+56.5,0])
        square([d3, d4],true);
        translate([-147.5+69,28.5+64,0])
        square([d3, d4],true);
        translate([-147.5+92,28.5+58,0])
        square([d3, d4],true);
        translate([-147.5+119,28.5+49,0])
        square([d3, d4],true);
    }
}

//layer 3
translate([190*2+10,10,0])
difference() {
    base(155+20,130);
    //translate([-10,10,0])
    //translate([-3,3,0])
    translate([180,-13,0]) {
        //loetung
        translate([-147.5,28.5+65+45,0])
        square([15,20],true);
        translate([-147.5,28.5+65+25,0])
        square([10,20],true);
        translate([-147.5-10,28.5+65,0])
        square([5,50],true);
        translate([-147.5,28.5+65,0])
        square([25,50],true);
        translate([-147.5+10,28.5+65,0])
        square([5,50],true);
        translate([-147.5+59.5,28.5+92.5,0])
        square([52+d5,22+d6],true);
        translate([-147.5,28.5,0])
        square([d3, d4],true);
        translate([-147.5+27,28.5,0])
        square([d3, d4],true);
        translate([-147.5+46,28.5+56.5,0])
        square([d3, d4],true);
        translate([-147.5+69,28.5+64,0])
        square([d3, d4],true);
        translate([-147.5+92,28.5+58,0])
        square([d3, d4],true);
        translate([-147.5+119,28.5+49,0])
        square([d3, d4],true);
        //content
        translate([-147.5+15,28.5+6,0])
        square([50, 30],true);
        translate([-147.5+65,28.5+20,0])
        square([80, 30],true);
        translate([-147.5+75,28.5+30,0])
        square([90, 30],true);       
        translate([-147.5+65,28.5+60,0])
        square([110, 30],true);
        translate([-147.5+60,28.5+70,0])
        square([30, 30],true);  
    }

}
translate([190*2+10,10,0])
translate([180,-13,0]) {
    //translate([-147.5+59.5,28.5+92.5,0])
    //square([52+d5-1,22+d6-1],true);
    translate([-147.5+59.5-25,28.5+92.5,0])
    square([4,12],true);
    translate([-147.5+59.5+25,28.5+92.5,0])
    square([4,12],true);
}

//layer 4
translate([190*3+10,10,0])
difference() {
    base(155+20,130);
    //translate([-10,10,0])
    //translate([-3,3,0])
    translate([180,-13,0]) {
        //loetung
        translate([-147.5,28.5+65+45,0])
        square([15,20],true);
        translate([-147.5,28.5+65+25,0])
        square([10,20],true);
        translate([-147.5-10,28.5+65,0])
        square([5,5],true);
        //translate([-147.5,28.5+65,0])
        //square([25,50],true);
    }

}

*/

module base(a,b) {

    difference() {
        union() {
            difference() { 
                square([a,b],false);
                //translate([20-1,20-1,0])
                //square([160+2,110+2],false);
                translate([5,5,0])
                square([10,10],true);
                translate([a-10,10,0])
                translate([5,-5,0])
                square([10,10],true);
                translate([10,b-10,0])
                translate([-5,5,0])
                square([10,10],true);
                translate([a-10,b-10,0])
                translate([5,5,0])
                square([10,10],true);  
            }
            translate([10,10,0])
            circle(10);
            translate([a-10,10,0])
            circle(10);
            translate([10,b-10,0])
            circle(10);
            translate([a-10,b-10,0])
            circle(10);
        }
        translate([10,10,0])
        circle(4.1);
        translate([a-10,10,0])
        circle(4.1);
        translate([10,b-10,0])
        circle(4.1);
        translate([a-10,b-10,0])
        circle(4.1);
    }
}
