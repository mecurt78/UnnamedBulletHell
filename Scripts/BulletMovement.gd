extends Sprite2D

## Number of pixels per second this bullet will move.
@export var speed : float = 400
## The direction this bullet will travel. Positive X is right, positive Y is down.
@export var direction : Vector2 = Vector2(0.0, -1.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("BulletMovement created.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = speed * delta
	transform.origin += distance * direction
