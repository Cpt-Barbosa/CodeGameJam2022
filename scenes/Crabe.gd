extends Area2D

export var speed = 300
var dir = Vector2()
const FLOOR_NORMAL = Vector2(0,-1)
export var pas = 100
var time = 0
var timer = null

func _ready():
	$AnimatedSprite.play()
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(10)
	timer. connect("timeout", self, "timeout_complete")
	add_child(timer)
	timer.start()
	
func _physics_process(delta):
	dir.x = speed *delta
	time += 1
	if fmod(time, pas) == 0.00:
		speed = speed * -1
		
	position +=dir

func timeout_complete():
	$Clac.play()

func _on_Crabe_body_entered(body):
	if body.get("type") == "Joueur":
		self.get_parent().get_node("barreOxy").RemoveAir(10)
		$KiwiAie.play()
	if body.get("type") == "Ancre":
		mourir()

func mourir():	
	queue_free()
