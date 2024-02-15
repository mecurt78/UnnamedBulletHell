extends CharacterBody2D

## This value is the maximum speed of the object. Measured in pixels/second.
@export var speed : float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Created a test player.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate distance to move.
	var distance : float = speed * delta
	# Get the direction.
	var direction : Vector2 = GetSteering()
	# Get the displacement.
	var displacement : Vector2 = direction * distance
	#position += displacement
	velocity  = direction

# Get the direction to move.
func GetSteering():
	var x = 0
	var y = 0
	if Input.is_action_pressed("ui_up"):
		# Go up.
		y += 1
	if Input.is_action_pressed("ui_down"):
		# Go down.
		y -= 1
	if Input.is_action_pressed("ui_left"):
		# Go left.
		x += 1
	if Input.is_action_pressed("ui_right"):
		# Go right.
		x -= 1
	return Vector2(x, y).normalized()
