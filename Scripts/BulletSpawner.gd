extends Node
class_name BulletSpawner
const bullet: PackedScene = preload("res://TestBullet.tscn")


static func new_bullet(dir : Vector2, position, col : TestBullet.CollisionType) -> TestBullet:
	var new_bullet: TestBullet = bullet.instantiate()
	#var bullet_script = new_bullet.get_script()
	# Set up all member variables accordingly.
	new_bullet.direction = dir
	new_bullet.position = position
	new_bullet.collisionType = col
	return new_bullet


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
