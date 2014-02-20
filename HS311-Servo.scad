 use <MCAD/boxes.scad>

servo_width = 1.57;
servo_depth = 0.78;
base_height = 1.04;
top_height = 0.65;
screws_distance_depth = 0.40;
screws_distance_width = 1.88;
screw_width=0.172;
ears_width = 2.08;
ears_height = 0.096;
ears_top_height = 0.1425;
round_top_depth = 0.6990;
round_top_width = 1.415;
round_top_height = 0.12;
rounded = .05;
top_cylinder_height=0.0750;
top_cylinder_radius=0.25;
top_cylinder_offset = 0.65-top_cylinder_radius;
wheel_inner_cylinder_height = 0.20-top_cylinder_height;
wheel_height=0.077;
wheel_radius=0.9390/2.0;

cable_box_width = 0.07;
cable_box_depth = 0.24;
cable_box_height = 0.13;


$fs=0.01;


module hs311_screw(){
	cylinder(h=2*ears_height, r=screw_width/2.0, center=true);
}

module hs311(position, rotation, screws = 0, axle_lenght = 0)
{
	translate(position)
	{
		rotate(rotation)
	    {
			union()
			{
                //main body
                roundedBox([servo_width,servo_depth,base_height],rounded,true);
				 translate([-servo_width/2.0,0,-base_height/2.0+cable_box_height/2.0]) roundedBox([cable_box_width,cable_box_depth,cable_box_height], rounded/10,true);
                translate([0,0,base_height/2.0 + ears_height /2.0]){
 	                difference(){
                    roundedBox([ears_width, servo_depth, ears_height ],rounded,true);
					union(){

                    translate([(ears_width-screw_width)/2.0+0.01, screws_distance_depth/2.0, 0]) hs311_screw();
                    translate([(ears_width-screw_width)/2.0+0.01, -screws_distance_depth/2.0, 0]) hs311_screw();
                    translate([-(ears_width-screw_width)/2.0-0.01, screws_distance_depth/2.0, 0]) hs311_screw();
                    translate([-(ears_width-screw_width)/2.0-0.01, -screws_distance_depth/2.0, 0]) hs311_screw();
					}
					}


                    
    				translate([ 0,0, ears_height/2.0 + ears_top_height/2.0 ]){
	    	            roundedBox([servo_width,servo_depth, ears_top_height ],rounded,true);
						 translate([0,0,ears_top_height/2.0 + round_top_height/2.0]) {
							translate([(servo_width-round_top_width)/-2,0,0])
                                roundedBox([round_top_width,round_top_depth,round_top_height ],rounded,true);
							translate([-servo_width/2.0+top_cylinder_offset,0,round_top_height/2.0+top_cylinder_height/2.0]){
								cylinder(h=top_cylinder_height,r=top_cylinder_radius,center=true);
								translate([0,0,top_cylinder_height/2.0]) {
									cylinder(h=wheel_inner_cylinder_height,r=0.16);
									  translate([0,0,wheel_inner_cylinder_height/2.0])
                                             cylinder(h=wheel_height,r=wheel_radius);
									}
								}
                        }
					 }
				 }				                
            }
        }
    }
}



module test_hs311(){hs311();}


test_hs311();