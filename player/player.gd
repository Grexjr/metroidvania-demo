extends CharacterBody2D

# SIGNALS: broadcasts when something is triggered
signal hit

@export var speed = 400
@export var jump_velocity = -500
var screen_size


# Called when the node enters the scene tree for the first time.d
func _ready() -> void:
	screen_size = get_viewport_rect().size
	# Player hidden when game starts
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame. For physics objects
func _physics_process(delta: float) -> void:
	# Apply gravity automatically if player is in the air
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Check for jump input, only allowed if on floor
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Get horizontal input movement (direction becomes boolean it seems)
	var direction := Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x,0,speed)
		
	# Move character using velocities
	move_and_slide()
	
	# Animation - if velocity is not zero, play walk animation and flip if neg
	if velocity.x != 0:
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = velocity.x < 0
	if velocity.y != 0:
		$AnimatedSprite2D.play("jump")
	else:
		$AnimatedSprite2D.stop()  
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
# Takes in bounds, with type hint that it is a rect2 and returns void
func set_camera_bounds(bounds: Rect2) -> void:
	# Gets the position of the bounds, adds width and height for other side
	$Camera2D.limit_left = bounds.position.x
	$Camera2D.limit_right = bounds.position.x + bounds.size.x
	$Camera2D.limit_top = bounds.position.y
	$Camera2D.limit_bottom = bounds.position.y + bounds.size.y
	


func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit
	hit.emit()
	# Must be deffered as we cannot change physics properties on a physics callback
	# Basically means we just trigger hit once when the player is hit and not repeatedly
	$CollisionShape2D.set_deferred("disabled",true)
