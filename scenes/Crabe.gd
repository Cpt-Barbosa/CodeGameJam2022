extends KinematicBody2D

export var speed = 300
var gravity = 10
var dir = Vector2()
const FLOOR_NORMAL = Vector2(0,-1)
export var pas = 100
var time = 0

func _physics_process(delta):
	dir.x = speed
	time += 1
	if !self.is_on_floor():
		dir.y = gravity
	if fmod(time, pas) == 0.00:
		speed = speed * -1
		
	move_and_slide(dir, FLOOR_NORMAL)
	check_collisions(dir,delta)

func check_collisions(dir,delta):
	var collision = move_and_collide(dir * delta)
	if collision && collision.collider.get("type") == "Joueur":
		collision.collider.notification(0)
	if collision && collision.collider.get("type") == "Ancre":	
		mourir()

func mourir():	
	queue_free()
