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

var hasCoffre

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	if hasCoffre:
		state_machine.travel("base coffre")
	velocity.y += get_gravity() * delta
	if velocity.y >= 98:
		velocity.y=98
	velocity.x = get_input_velocity() * move_speed
	
	if Input.is_action_just_pressed("attack"):
		if hasCoffre:
			state_machine.travel("Attaque (coffre)")
		else:
			state_machine.travel("Attaque")
	if Input.is_action_just_pressed("jump") and jump_count >0:
		jump_count -=1
		jump()
	elif self.is_on_floor():
		jump_count=2
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	check_collisions(velocity,delta)

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

func check_collisions(dir,delta):
	var collision = move_and_collide(velocity * delta,true)
	if collision && collision.collider.get("type") == "Coffre":
		collision.collider.notification(0)
		hasCoffre=true
		
func die():
	state_machine.travel("mort")
	set_physics_process(false)
	
func _get(property):
	if property == "type":
		return "Joueur"
		
func _notification(what):
	if what == 0:
		pass
