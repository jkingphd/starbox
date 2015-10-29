module poly(n_sides, r, l, rnd = 0) {
    r = r - l;
    theta = 360/n_sides;
    //echo(theta);
    pts_1 = [for (i = [0:theta:360]) [r*sin(i),r*cos(i)]];
    //echo(pts_1);
    
    h = r*cos(theta/2);
    s = r*sin(theta/2);
    //echo(h);
    
    pts_2 = [[-s,0],[0,l+(r-h)],[s,0]];
    //echo(pts_2);
    
    if (rnd == 0) {
        union() {
            for (i = [0:360/n_sides:360]) 
                rotate(i)
                union() {
                    rotate([0,0,-theta/2])
                    polygon(pts_1);
                    
                    translate([0,h,0])
                    polygon(pts_2);
                }
        }
    }
    else {
        minkowski(){
            union() {
                for (i = [0:360/n_sides:360]) 
                    rotate(i)
                    union() {
                        rotate([0,0,-theta/2])
                        polygon(pts_1);
                        
                        translate([0,h,0])
                        polygon(pts_2);
                    }
            }
            circle(rnd, $fn = 32);
        }
    }
}

n = 7; // Number of sides
r = 30; // Radius of the box in mm
l = 10; // Length of each arm in mm
h = 15; // Height of the box
w = 1.2; // Wall thickness in mm
b_l = 1; // Thickness of bottom wall in mm
r_f = 2; // Roundness factor

// Build the box
//translate([-1.5*r,0,0])
union() {
    linear_extrude((8*h/10) - b_l)
    difference() {
        poly(n, r, l, r_f);
        offset(-w)
        poly(n, r, l, r_f);
    }
    linear_extrude(b_l)
    poly(n, r, l, r_f);
}

//// Build the lid
////translate([1.5*r,0,0])
//union() {
//    linear_extrude(2*h/10)
//    difference() {
//        offset(-w)
//        poly(n, r, l, r_f);
//        offset(-2*w)
//        poly(n, r, l, r_f);
//    }
//    linear_extrude(h/10)
//    poly(n, r, l, r_f);
//}