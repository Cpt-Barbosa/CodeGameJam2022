extends KinematicBody2D
var vie = 3
export var speed = 500
var dir = Vector2()

const FLOOR_NORMAL = Vector2(0 , -1)

func _physics_process(delta):
	$AnimatedSprite.play()
	dir.x = speed
	move_and_slide(dir,FLOOR_NORMAL)

	var collision = move_and_collide(dir * delta)
	if collision && collision.collider.name == "Joueur":
		vie = vie -1
		collision.collider.notification(0)
	
		
func _notification(what):
	if what == 0:
		queue_free()

func _on_Area2D_area_entered(area):
	speed = speed *-1
	if $AnimatedSprite.flip_h == true :
		$AnimatedSprite.flip_h = false
	elif $AnimatedSprite.flip_h == false :
		$AnimatedSprite.flip_h = true
		
func mourir():
	var posx = self.position.x
	var posy = self.position.y
	var ressource = load("scenes/BulleAir.tscn").instance()
	ressource.transform = Transform2D(0, Vector2(posx,posy))
	
	get_tree().get_root().get_child(0).add_child(ressource)

