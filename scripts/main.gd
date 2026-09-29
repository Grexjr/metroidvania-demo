extends Node

# Waits to instantiate/refer until scene tree is fully ready
@onready var player = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RoomManager.current_room_container = $CurrentRoom
	RoomManager.player = player
	var starting_room: String = "test_room"
	# Use preload for hard-coded path to load the first room
	RoomManager.load_room(starting_room,"StartPosition")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
