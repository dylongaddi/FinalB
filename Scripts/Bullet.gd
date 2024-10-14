extends RigidBody2D
class_name Bullet

# Called when the node enters the scene tree for the first time.
signal boss_hit
signal player_hit
@export var velocity:Vector2
@export var duration = 2
@onready var sprite = $Sprite2D
@export var boss: CharacterBody2D

var direction = Vector2.RIGHT
var speed = 0.0
	


func _physics_process(delta):
	velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	
	if collision:
		var entity = collision.get_collider()
		if entity is Boss:
			entity.take_damage(1)
			pass
		if entity.is_in_group("players"):
			pass
		queue_free()
	
		
	
	
