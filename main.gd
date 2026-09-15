extends Node

# Allows us to choose the mob scene we want to instance
@export var mob_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.start($StartPosition.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$HUD.show_game_over()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	get_tree().call_group("mobs","queue_free")
	$Music.play()
	


func _on_mob_timer_timeout() -> void:
	# Create new instance of mob scene
	var mob = mob_scene.instantiate()
	
	# Choose a random location on Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# Set mob's position to random location
	mob.position = mob_spawn_location.position
	
	# Set the mob's direction perpendicular to path direction
	var direction = mob_spawn_location.rotation + PI/2
	
	# Add randomness
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Choose velocity
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn mob by adding to main scene
	add_child(mob)
	# Need to add the mobs to the group so they get disappeared at the end
	mob.add_to_group("mobs")


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
