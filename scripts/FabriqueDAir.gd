extends Node2D

signal timeout

const TIME_PERIOD = 5 # 500ms

var time = 0

#func _process(delta):
#	time += delta
#	if time > TIME_PERIOD:
#		emit_signal("timeout")
#		# Reset timer
#		time = 0
#		var posx = self.position.x
#		var posy = self.position.y
#		var ressource = load("scenes/BulleAir.tscn").instance()
#		ressource.transform = Transform2D(0, Vector2(posx,posy))


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Kiwi")
	var posx = self.position.x + 5
	var posy = self.position.y
	print(posx)
	print(posy)
	var ressource = load("scenes/BulleAir.tscn").instance()
	ressource.transform = Transform2D(0, Vector2(posx,posy))
	get_tree().get_root().get_child(0).add_child(ressource)

func _notification(what):
	if what == 0:
		self.get_parent().get_node("barreOxy").AddAir(25)
		queue_free()

