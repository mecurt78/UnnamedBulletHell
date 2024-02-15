extends "res://Scripts/SteeringBehavior.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
	return Vector2(x, y)
