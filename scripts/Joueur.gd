extends KinematicBody2D

export var move_speed = 200.0

var state_machine
var velocity := Vector2.ZERO

export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
onready var jump_count = 2

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	velocity.y += get_gravity() * delta
	velocity.x = get_input_velocity() * move_speed
	
	if Input.is_action_just_pressed("attack"):
		state_machine.travel("Attaque")
	if Input.is_action_just_pressed("jump") and jump_count >0:
		jump_count -=1
		jump()
	elif self.is_on_floor():
		jump_count=2
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var collision = move_and_collide(velocity * delta)
	if collision && collision.collider.name == "Coffre":
		collision.collider.notification(0)
		#print("I collided with ", collision.collider.name)
	if collision && collision.collider.name == "requin":
		collision.collider.notification(0)
		collision.collider.mourir()
	if collision && collision.collider.get("BulleAir") == "BulleAir":
		collision.collider.notification(0)
		#print("I collided with ", collision.collider.name)

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity

func get_input_velocity() -> float:
	var horizontal := 0.0
	
	if !self.is_on_floor():
			pass
			#self.get_child(1).set_animation("falling")
			
	if Input.is_action_pressed("move_left"):
		if self.is_on_floor():
			self.get_child(2).flip_v=true
			self.rotation_degrees=180
		horizontal -= 1.0
		
	if Input.is_action_pressed("move_right"):
		if self.is_on_floor():
			self.get_child(2).flip_v=false
			self.rotation_degrees=0
		horizontal += 1.0
	
	return horizontal

func die():
	state_machine.travel("mort")
	set_physics_process(false)

func _notification(what):
	if what == 0:
		pass
