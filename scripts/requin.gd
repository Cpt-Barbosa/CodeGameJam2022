extends KinematicBody2D

export var speed = 500
var dir = Vector2()
const FLOOR_NORMAL = Vector2(0 , -1)

func _physics_process(delta):
	$AnimatedSprite.play()
	dir.x = speed
	move_and_slide(dir,FLOOR_NORMAL)



func _on_Area2D_area_entered(area):
	speed = speed *-1
	if $AnimatedSprite.flip_h == true :
		$AnimatedSprite.flip_h = false
	elif $AnimatedSprite.flip_h == false :
		$AnimatedSprite.flip_h = true
