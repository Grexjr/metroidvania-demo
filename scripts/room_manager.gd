# SINGLETON ROOM MANAGER AUTOLOAD

extends Node

var current_room: Room # Reference to the actual room that is loaded
var current_room_container: Node2D # Permanenet "slot" in main that holds the loaded room as child
	# Node because just organizational, but any effects using transitions etc can make this Node2D
var player: CharacterBody2D	# Reference to the player

func load_room(room_name: String, spawn_point_name: String) -> void:
	if current_room:
		current_room.queue_free()
	
	# Always loads rooms from the hard coded path, means in editor you just type the name of the room
	var room_scene: PackedScene = load("res://scenes/rooms/"+room_name+".tscn")
	var new_room: Room = room_scene.instantiate()
	current_room_container.add_child(new_room)
	current_room = new_room
	
	var spawn = new_room.get_node(spawn_point_name)
	player.global_position = spawn.global_position
	
	# Set the player's camera bounds to the room
	player.set_camera_bounds(current_room.get_room_bounds())



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
