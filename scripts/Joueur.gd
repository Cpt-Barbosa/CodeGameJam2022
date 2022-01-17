extends KinematicBody2D

export (int) var speed = 200
const FLOOR_NORMAL = Vector2(0 , -1)

var velocity = Vector2()

func _ready():
	self.set_scale(Vector2( 1, 1 ))
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		if self.is_on_floor():
			self.get_child(1).set_frame(0)
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		if self.is_on_floor():
			self.get_child(1).set_frame(1)
	else :
		if !self.is_on_floor():
			self.get_child(1).set_frame(2)
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity")
	velocity = move_and_slide(velocity,FLOOR_NORMAL)
	

