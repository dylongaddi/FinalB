extends RigidBody2D
class_name Bullet


# Called when the node enters the scene tree for the first time.
var speed = 750
signal hit
var velocity:Vector2

func start(_position, _direction):
	rotation = _direction
	position = _position
	velocity = Vector2(speed, 0).rotated(rotation)
	

func project(direction:Vector2, speed:float):
	velocity = direction * speed

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		hit.emit()
		queue_free()
	
	
