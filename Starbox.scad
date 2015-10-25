module poly(n_sides, r, l, rnd = 0) {
    r = r - l;
    theta = 360/n_sides;
    //echo(theta);
    pts_1 = [for (i = [0:theta:360]) [r*sin(i),r*cos(i)]];
    echo(pts_1);
    
    h = r*cos(theta/2);
    s = r*sin(theta/2);
    echo(h);
    
    pts_2 = [[-s,0],[0,l+(r-h)],[s,0]];
    echo(pts_2);
    
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

// Build the box
union() {
    linear_extrude(25.4)
    difference() {
        poly(5, 50.8, 25.4, 1);
        offset(-2)
        poly(5, 50.8, 25.4, 1);
    }
    linear_extrude(2)
    poly(5, 50.8, 25.4, 1);
}