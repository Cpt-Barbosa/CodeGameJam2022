extends RigidBody2D


var state_machine
var timer

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(1)
	timer. connect("timeout", self, "timeout_complete")
	add_child(timer)

func timeout_complete() :
	queue_free()


func _on_mduse_body_entered(body):
	if body.get("type")=="Ancre":
		state_machine.travel("Mort")
		$Splash.play()
		self.get_child(3).disabled=true
		timer.start()
	if body.get("type")=="Joueur":
		self.get_parent().get_node("barreOxy").RemoveAir(5)
		$KiwiAie.play()
