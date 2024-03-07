extends CharacterBody2D
class_name TestBullet

## Number of pixels per second this bullet will move.
@export var speed : float = 400
## The direction this bullet will travel. Positive X is right, positive Y is down.
@export var direction : Vector2 = Vector2(0.0, -1.0)
## The amount of damage this bullet will do.
@export var damage : int = 1
## Maximum number of collisions the bullet can do before it disappears. TODO: Add animation for hits and despawning?
@export var maxCollisions : int = 1
@export var lifeTime : float = 10.0
var currentLifeTime : float = 0.0
@export var collideWithEnemy : bool = true
@export var collideWithPlayer : bool = false

#func _init(dir : Vector2, position, enemy: bool = true, player: bool = false):
	#collideWithEnemy = enemy
	#collideWithPlayer = player
	#direction = dir
	#self.transform.origin = position

# Called when the node enters the scene tree for the first time.
func _ready():
	print("bullet created at")
	print(transform.origin)
	print("BulletMovement created.")
	print("Moving towards:")
	print(direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("Bullet position is ")
	print(transform.origin)
	#var distance = speed * delta
	#transform.origin += distance * direction
	# Move and check collisions. TODO: Find a way to further separate movement and collision logic.
	var velocity = speed * direction
	var collision_count = 0
	var collision = move_and_collide(velocity * delta)
	while (collision):
		var collider = collision.get_collider()
		if collider is TestEnemy and collideWithEnemy:
			print("Collided with an enemy.")
			collider.hit(damage)
			maxCollisions -= 1
			break	# Same as break in C++, breaks out of this loop.
		elif collider is TestPlayer and collideWithPlayer:
			collider.hit(damage)
			maxCollisions -= 1
		else:
			print("Collided with unknown object:")
			print(collider)
		# The movement was interrupted by this collision; continue to move.
		var remainingDistance = collision.get_remainder()
		collision = move_and_collide(remainingDistance)
	if (maxCollisions <= 0):
		queue_free()
	
	# Check the lifetime. TODO: Move this into a timer?
	currentLifeTime += delta
	if (currentLifeTime > lifeTime):
		queue_free()


func _on_rigid_body_2d_body_entered(body):
	# Handles the signal for when the bullet's RigidBody2D collides with something.
	print("Bullet hit something.")
	pass # Replace with function body.
