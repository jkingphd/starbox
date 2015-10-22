module poly(n_sides, r, l, height) {
    theta = 360/n_sides;
    echo(theta);
    pts_1 = [for (i = [0:theta:360]) [r*sin(i),r*cos(i)]];
    echo(pts_1);
    
    h = r*cos(theta/2);
    s = r*sin(theta/2);
    
    pts_2 = [[-s,0],[0,l],[s,0]];
    echo(pts_2);
    
    linear_extrude(height)
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

n_sides = 5;
radius = 30;
arm_length = 25.4;
height = 5;

poly(n_sides, radius, arm_length, height);