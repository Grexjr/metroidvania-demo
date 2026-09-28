# SINGLETON ROOM MANAGER AUTOLOAD

extends Node

var current_room: Node2D # Reference to the actual room that is loaded
var current_room_container: Node # Permanenet "slot" in main that holds the loaded room as child
	# Node because just organizational, but any effects using transitions etc can make this Node2D
var player: CharacterBody2D	# Reference to the player

func load_room(room_scene: PackedScene, spawn_point_name: String) -> void:
	if current_room:
		current_room.queue_free()
		
	var new_room = room_scene.instantiate()
	current_room_container.add_child(new_room)
	current_room = new_room
	
	var spawn = new_room.get_node(spawn_point_name)
	player.global_position = spawn.global_position



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
