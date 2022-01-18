extends Area2D
var vie = 3
export var speed = 500
var dir = Vector2()

const FLOOR_NORMAL = Vector2(0 , -1)

func _physics_process(delta):
	$AnimatedSprite.play()
	dir.x = speed*delta
	self.position+=dir

		
func _notification(what):
	pass
	
func _get(property):
	if property == "type":
		return "Requin"

func mourir():
	var posx = self.position.x
	var posy = self.position.y
	var ressource = load("scenes/BulleAir.tscn").instance()
	ressource.transform = Transform2D(0, Vector2(posx,posy))
	get_tree().get_root().get_child(0).add_child(ressource)
	
	queue_free()



func _on_requin_body_entered(body):
	if body.get("type") == "Ancre":
		vie -= 1
		if vie == 0:
			mourir()
		speed = speed *-1
		if $AnimatedSprite.flip_h == true :
			$AnimatedSprite.flip_h = false
		elif $AnimatedSprite.flip_h == false :
			$AnimatedSprite.flip_h = true


func _on_requin_area_entered(area):
	speed = speed *-1
	if $AnimatedSprite.flip_h == true :
		$AnimatedSprite.flip_h = false
	elif $AnimatedSprite.flip_h == false :
		$AnimatedSprite.flip_h = true
