@tool
extends RigidBody2D
class_name Bullet

# Called when the node enters the scene tree for the first time.
signal hit
@export var velocity:Vector2
@export var duration = 2
@onready var sprite = $Sprite2D

var direction = Vector2.RIGHT
var speed = 0.0
	

func _physics_process(delta):
	velocity = direction * speed * delta
	rotation = velocity.angle()
	var collision = move_and_collide(velocity)
	
	if collision:
		queue_free()
	
		
	
	
