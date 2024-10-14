extends CharacterBody2D
class_name Boss

signal healthChanged

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite = $AnimatedSprite2D

@export var maxHealth = 1000
@onready var currentHealth: int = maxHealth
const _bullet = preload("res://Scenes/bullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(_delta):
	# Add the gravity.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction
	if direction:
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)


func take_damage(amount: int):
	currentHealth = max(currentHealth - amount, 0)
	healthChanged.emit()  # Emit signal when health changes


	
