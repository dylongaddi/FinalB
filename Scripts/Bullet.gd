extends RigidBody2D
class_name Bullet

# Called when the node enters the scene tree for the first time.
@export var velocity:Vector2
@export var duration = 100
@export var bulletSprite: Texture
@onready var sprite = $Sprite2D

var damage = 1
var direction = Vector2.RIGHT
var speed = 0.0

func ready():
	sprite.texture = bulletSprite

func _physics_process(delta):
	velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	
	if collision:
		var entity = collision.get_collider()
		if entity is Boss:
			entity.take_damage(damage)
		if entity is Player:
			entity.take_damage(0.5)
		queue_free()
		
	duration -= 1
	if duration < 0:
		queue_free()
	
		
	
	
