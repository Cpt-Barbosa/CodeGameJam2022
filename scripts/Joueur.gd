extends KinematicBody2D

export (int) var speed = 350
var God_Mod = true
const FLOOR_NORMAL = Vector2(0 , -1)
var jump_count = 2
#...
# Vertical impulse applied to the character upon jumping in meters per second.
export var jump_impulse = 9000

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if !self.is_on_floor():
			self.get_child(1).set_animation("falling")
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		if self.is_on_floor():
			self.get_child(1).set_animation("moving")
			self.get_child(1).set_flip_h(false)
	elif Input.is_action_pressed("move_left"):
		velocity.x -= speed
		if self.is_on_floor():
			self.get_child(1).set_animation("moving")
			self.get_child(1).set_flip_h(true)
	if Input.is_action_just_pressed("jump"):
		if jump_count > 0:
			jump_count -= 1
			velocity.y -= jump_impulse	
	velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity")
	#print(str(position.y))

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity,FLOOR_NORMAL)
	if self.is_on_floor():
		jump_count=2
	if self.get_child(3).GetBarreVide() && !God_Mod:
		print("mort")

