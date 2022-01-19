extends KinematicBody2D

export var move_speed = 200.0

var state_machine
var velocity := Vector2.ZERO
var timer = null
var rip = false
var derniereCase

export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float
export var MAX_ACCELERATION : float

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
onready var jump_count = 2

var hasCoffre = false

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(3.5)
	timer. connect("timeout", self, "timeout_complete")
	add_child(timer)

func _physics_process(delta):
	if hasCoffre:
		state_machine.travel("base coffre")
	velocity.y += get_gravity() * delta
	if velocity.y >= MAX_ACCELERATION:
		velocity.y=MAX_ACCELERATION
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
	
	
	check_collisions(velocity,delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	


func timeout_complete() :
	self.get_tree().change_scene("res://scenes/MenuMort.tscn")

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity
	derniereCase = ""

func get_input_velocity() -> float:
	var horizontal := 0.0
	
	if !self.is_on_floor():
			pass
			#self.get_child(1).set_animation("falling")
			
	if Input.is_action_pressed("move_left"):
		self.get_child(2).flip_v=true
		self.rotation_degrees=180
		self.get_child(0).rotation_degrees=180
		horizontal -= 1.0
		
	if Input.is_action_pressed("move_right"):
		self.get_child(2).flip_v=false
		self.rotation_degrees=0
		self.get_child(0).rotation_degrees=0
		horizontal += 1.0
	
	return horizontal

func check_collisions(dir,delta):
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		#print("I collided with ", collision.collider.name)
		if collision.collider.name == "piege" && derniereCase != "piege":
			derniereCase = "piege"
			self.get_parent().get_node("barreOxy").RemoveAir(2)
			
		if collision.collider.name == "Floor" && derniereCase != "Floor":
			derniereCase = "Floor"
			
		if collision.collider.name == "Coffre" && derniereCase != "Coffre":
			derniereCase = "Coffre"
			collision.collider.notification(0)
			hasCoffre=true
			self.get_tree().change_scene("res://scenes/Niveau2.tscn")
		
func die():
	state_machine.travel("mort")
	$CriAgonie.play(0)
	set_physics_process(false)
	timer.start()
	
func _get(property):
	if property == "type":
		return "Joueur"
		
func _notification(what):
	if what == 0:
		pass
