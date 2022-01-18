extends Node2D

func _physics_process(delta):
	if collision.collider is TileMap:
		var tile_pos = collision.collider.world_to_map(position)
		tile_pos -= collision.normal
		var tile_id = collision.collider.get_cellv(tile_pos)
