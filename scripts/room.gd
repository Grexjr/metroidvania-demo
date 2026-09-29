class_name Room
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Hint to return Rect2
func get_room_bounds() -> Rect2:
	# Get the tile map's rectangle shape
	var rectangle: Rect2i = $Tiles.get_used_rect()
	var tile_size: Vector2i = $Tiles.tile_set.tile_size
	# Use vector2 to multiply the rectangle by the tile size
	var top_left = Vector2(rectangle.position) * Vector2(tile_size)
	var size = Vector2(rectangle.size) * Vector2(tile_size)
	# Create a rect2 object with the new top left and size values
	return Rect2(top_left,size)
