extends CharacterBody2D
class_name Player

signal running(value)
signal healthChanged

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
@onready var sprite = $AnimatedSprite2D
@onready var gun = $AnimatedSprite2D/Anchor/Gun
@onready var gunAnchor = $AnimatedSprite2D/Anchor
@export var friction = 3.0 

@export var maxHealth = 5
@export var ammoCount = 30
@onready var currentHealth: int = maxHealth



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() or Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		sprite.play("run")
		if direction > 0:
			sprite.scale.x = 1
		elif direction < 0:
			sprite.scale.x = -1
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta * friction)
		sprite.play("idle")
		
		

	move_and_slide()
	
	if Input.is_action_pressed("shoot"):
		if gun.firerateTimer.is_stopped():
			gun.shoot()
			gunAnchor.rotation = gun.gun_direction
			if sprite.scale.x == 1:
				gunAnchor.scale = Vector2(1, 1)
				gunAnchor.rotation = gun.gun_direction
			elif sprite.scale.x == -1:
				gunAnchor.scale = Vector2(-1, -1)
				gunAnchor.rotation = -gun.gun_direction
				pass
			ammoCount -= 1

func take_damage(amount: int):
	currentHealth = max(currentHealth - amount, 0)
	healthChanged.emit()  # Emit signal when health changes
