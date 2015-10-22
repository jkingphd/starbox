module poly(r, n, l) {
    theta = 360/n;
    echo(theta);
    points = [for (i = [0:theta:360]) [r*sin(i),r*cos(i)]];
    echo(points);
    
    h = r*cos(theta/2);
    s = r*sin(theta/2);
    
    pts2 = [[-s,0],[0,l],[s,0]];
    echo(pts2);
    
    union() {
    translate([0,h,0])
    polygon(pts2);
        
    rotate([0,0,-theta/2])
    polygon(points);
    }
}


//poly(25.4, 5);
//rotate(-360/5)
//poly(25.4, 5);

sides = 5;
arm_length = 25.4;

linear_extrude(5)
union() {
for (i = [0:360/sides:360]) rotate(i) poly(25.4, sides, arm_length);
}