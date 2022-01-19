extends Panel


var timer


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(10)
	timer. connect("timeout", self, "timeout_complete")
	add_child(timer)
	timer.start()


func timeout_complete() :
	var button = Button.new()
	button.connect("pressed", self, "button_pressed")
	button.set_position(Vector2(250, 500))
	button.text="Retourner au menu principal"
	add_child(button)

func button_pressed() :
	self.get_tree().change_scene("res://scenes/MainMenu.tscn")

