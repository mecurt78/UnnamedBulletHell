extends CharacterBody2D
class_name TestBullet

enum CollisionType {
	COLLIDE_WITH_PLAYER,
	COLLIDE_WITH_ENEMY,
	COLLIDE_WITH_PLAYER_AND_ENEMY,
	COLLIDE_WITH_ALL
}

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
@export var collisionType : CollisionType = CollisionType.COLLIDE_WITH_ALL
var collidedObjects = []

#func _init(dir : Vector2, position, col : CollisionType):
	#collisionType = col
	#direction = dir
	#self.transform.origin = position


# Called when the node enters the scene tree for the first time.
func _ready():
	print("bullet created at")
	print(transform.origin)
	print("Moving towards:")
	print(direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var distance = speed * delta
	#transform.origin += distance * direction
	# Move and check collisions. TODO: Find a way to further separate movement and collision logic.
	var velocity = speed * direction
	var collision_count = 0
	var distance = velocity * delta
	var collision = move_and_collide(distance)
	while (collision):
		if (maxCollisions <= 0):
			queue_free()
			break
		# Get what we collided with.
		var collider = collision.get_collider()
		# The movement was interrupted by this collision; continue to move. Get the next collision, if there is one, for the next loop iteration.
		var remainingDistance = collision.get_remainder()
		collision = move_and_collide(remainingDistance)
		if (collider in collidedObjects):
			print("Skipping a collision we already checked.")
			continue
		else:
			print("Saving a new collision.")
			collidedObjects.append(collider)
		if collider is TestEnemy and (collisionType == CollisionType.COLLIDE_WITH_ENEMY or collisionType == CollisionType.COLLIDE_WITH_PLAYER_AND_ENEMY or collisionType == CollisionType.COLLIDE_WITH_ALL):
			print("Collided with an enemy.")
			collider.hit(damage)
			maxCollisions -= 1
			continue	# Same as break in C++, breaks out of this loop.
		elif collider is TestPlayer and (collisionType == CollisionType.COLLIDE_WITH_PLAYER or collisionType == CollisionType.COLLIDE_WITH_PLAYER_AND_ENEMY or collisionType == CollisionType.COLLIDE_WITH_ALL):
			print("Collided with the player.")
			collider.hit(damage)
			maxCollisions -= 1
		elif collider is TestBullet:
			if (collisionType == CollisionType.COLLIDE_WITH_ALL):
				collider.queue_free()
				queue_free()
				continue
			else:
				# Ignore bullet collisions.
				continue
		else:
			print("Collided with unknown object:")
			print(collider)
	
	# Check the lifetime. TODO: Move this into a timer?
	currentLifeTime += delta
	if (currentLifeTime > lifeTime):
		queue_free()


func _on_rigid_body_2d_body_entered(body):
	# Handles the signal for when the bullet's RigidBody2D collides with something.
	print("Bullet hit something.")
	pass # Replace with function body.
