extends RigidBody2D


var instancedBullet = preload("res://TestBulet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fire"):
		# Fire a bullet.
		var newBullet = instancedBullet.instantiate()
		add_child(newBullet)
		newBullet.transform.origin = transform.origin
	pass
