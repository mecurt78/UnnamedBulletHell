extends CharacterBody2D
class_name TestEnemy

## How much health the enemy has.
@export var health : int = 10

## The player and target of the enemy.
@export var player : TestPlayer

## The speed to move.
@export var speed : float = 100

var shootTimer : Timer

var instancedBullet = preload("res://TestBullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	shootTimer = Timer.new()
	add_child(shootTimer)
	shootTimer.connect("timeout", shoot)
	shootTimer.wait_time = 5.0
	shootTimer.start()
	print("Created TestEnemy.")
	
	# Make sure the player is set.
	if player == null:
		print("Player is null, searching the level for it.")
		var playerNodes = []
		#get_tree().get_root()
		for node in get_tree().get_nodes_in_group("Player"):
			playerNodes.append(node)
		for node in playerNodes:
			print(node.name)
			if node is TestPlayer:
				print("Found a player.")
				player = node
				break


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Move towards the player.
	var direction = (player.global_position - global_position).normalized()
	var velocity = speed * direction
	var collision = move_and_collide(velocity * delta)
	while (collision):
		var collider = collision.get_collider()
		if collider is TestPlayer:
			print("Collided with the player.")
			collider.hit(1)
			break	# Same as break in C++, breaks out of this loop.
		else:
			print("Hit something else.")
		var remainingDistance = collision.get_remainder()
		collision = move_and_collide(remainingDistance)


## Deal damage to the enemy.
func hit(damage: int):
	health -= damage
	if (health <= 0):
		print("TestEnemy defeated.")
		queue_free()	# Deletes the node.


func shoot():
	print("TODO: Figure out how to make the enemy shoot.")
	#var targetPosition = player.global_position
	#var direction = (targetPosition - position).normalized()
	#var bulletInstance = instancedBullet.instantiate()
	##var bulletInstance = instancedBullet.instance()
	#bulletInstance._init(direction, position)
	#add_child(bulletInstance)
