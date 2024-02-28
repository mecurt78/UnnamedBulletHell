extends CharacterBody2D
class_name TestEnemy

## How much health the enemy has.
@export var health : int = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Created TestEnemy.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


## Deal damage to the enemy.
func hit(damage: int):
	health -= damage
	if (health <= 0):
		print("TestEnemy defeated.")
		queue_free()	# Deletes the node.
