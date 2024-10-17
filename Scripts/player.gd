extends CharacterBody2D
class_name Player

signal healthChanged
signal player_died

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
@onready var sprite = $AnimatedSprite2D
@onready var gun = $AnimatedSprite2D/Anchor/Gun
@onready var gunAnchor = $AnimatedSprite2D/Anchor
@onready var gunShotSound = $gunshotSFX
@export var friction = 3.0 

@export var maxHealth = 3.0
@export var ammoCount = 30
@export var ammoLabel: Label
@onready var currentHealth: float = maxHealth
var damagable = true


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
			if ammoCount > 0:
				gunShotSound.play()
				ammoCount -= 1
				if ammoLabel:
					if ammoCount < 10:
						ammoLabel.text = "0%d/30" % [ammoCount]
					else:
						ammoLabel.text = "%d/30" % [ammoCount]
				else:
					return

func take_damage(amount: float):
	if damagable:
		currentHealth -= amount
		healthChanged.emit()  # Emit signal when health changes
		if currentHealth >= 0:
			player_died.emit()
		castIframes()
			
func castIframes():
	damagable = false
	sprite.set_modulate(Color(1, 0, 0, 0.6))
	await get_tree().create_timer(1).timeout
	sprite.set_modulate(Color(1, 1, 1, 1))
	damagable = true

func _on_ammo_spawner_2_ammo_replenished():
	ammoLabel.text = "%d/30" % [ammoCount]



func _on_ammo_spawner_ammo_replenished():
	ammoLabel.text = "%d/30" % [ammoCount]

