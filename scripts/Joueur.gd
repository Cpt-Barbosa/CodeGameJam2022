extends KinematicBody2D
#Position variables used for movement
var x = 100
var y = 0
#Angle variable used for movement
var deg = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_child(1).play()

#Handles input via keyboard, mouse or controller
func _input(event):
	if(event.is_action("move_up")):
		x=0
		y=-100
		deg=-90
	elif(event.is_action("move_down")):
		x=0
		y=100
		deg=90
	elif(event.is_action("move_right")):
		x=100
		y=0
		deg=0
	elif(event.is_action("move_left")):
		x=-100
		y=0
		deg=-180
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.move_and_collide(Vector2(x*delta,y*delta))
	self.set_rotation(deg2rad(deg))
