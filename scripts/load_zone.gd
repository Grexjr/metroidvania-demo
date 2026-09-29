extends Area2D

# The room that the load scene connects to and the string that represents where it drops player
@export var target_room_path: String
@export var target_spawn_point: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function called when player enters the load zone bounds
func _on_body_entered(body: Node2D) -> void:
	# If player enters, call room manager load room functionality
	if body.is_in_group("player"):
		# Defers the call until after the physics tick has finished
		RoomManager.call_deferred("load_room",target_room_path,target_spawn_point)
	pass # Replace with function body.
