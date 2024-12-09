extends CharacterBody2D
class_name Player

signal healthChanged
signal died

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
@onready var sprite = $AnimatedSprite2D
@onready var gun = $AnimatedSprite2D/Anchor/Gun
@onready var gunAnchor = $AnimatedSprite2D/Anchor
@onready var gunShotSound = $gunshotSFX
@onready var ultCDTimer = $UltCooldownTimer
@onready var ultDurationTimer = $UltDurationTimer
@export var ultLabel = Label
@export var ultNameLabel = Label
@export var friction = 3.0  

@export var maxHealth = 3.0
@export var ammoCount = 30
@export var ammoLabel: Label
@export var GameManager: GameManager
@onready var currentHealth: float = maxHealth
var damagable = true
enum ULT {UNSTOPPABLE, DEADEYE, HYPERDRIVE}
var ult = ULT.DEADEYE
var ultCooldown = null
var isUsingUlt = false
var ultOnCooldown = false
var deadEYECOUNT = 0


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
			if ammoCount > 0 or (ammoCount == 0 and gun.isInfiniteAmmoOn):
				gunShotSound.play()
				if not gun.isInfiniteAmmoOn:
					ammoCount -= 1
				if ammoLabel:
					if ammoCount < 10:
						ammoLabel.text = "0%d/30" % [ammoCount]
					else:
						ammoLabel.text = "%d/30" % [ammoCount]
				else:
					return
	
	if Input.is_action_just_pressed("ult"):
		if ultCDTimer.is_stopped():
			useUlt(ult)
			pass
					
		
func _process(delta):
	if ultCooldown:
		ultLabel.text = "%d" % ult_cooldown()
	else:
		ultLabel.text = "READY"
	pass

func take_damage(amount: float):
	if damagable:
		currentHealth -= amount
		healthChanged.emit()  # Emit signal when health changes
		if currentHealth <= 0:
			print(died)
			died.emit()
		castIframes(1)

			
func castIframes(time):
	damagable = false
	sprite.set_modulate(Color(1, 0, 0, 0.6))
	await get_tree().create_timer(time).timeout
	sprite.set_modulate(Color(1, 1, 1, 1))
	damagable = true
	

func useUlt(ult):
	match ult:
		ULT.UNSTOPPABLE:
			castIframes(3)
			ultCooldown = 10
		ULT.DEADEYE:
			gun.critChance = 0.3
			gun.critDamage = 30
			ultCooldown = 18
			ultDurationTimer.wait_time = 5
		ULT.HYPERDRIVE:
			gun.firerateTimer.wait_time = 0.05
			gun.isInfiniteAmmoOn = true
			ultCooldown = 35
			ultDurationTimer.wait_time = 6
	ultDurationTimer.start()
	ultCDTimer.wait_time = ultCooldown
	ultCDTimer.start()
			
func setDefaultGunValues():
	gun.critChance = 0.2
	gun.critDamage = 20
	gun.isInfiniteAmmoOn = false
	gun.firerateTimer.wait_time = 0.1
	
func ult_cooldown():
	var time_left = ultCDTimer.time_left
	var second = int(time_left) % 60
	return second


func _on_ammo_spawner_2_ammo_replenished():
	ammoLabel.text = "%d/30" % [ammoCount]


func _on_ammo_spawner_ammo_replenished():
	ammoLabel.text = "%d/30" % [ammoCount]
	
func _on_ammo_spawner_3_ammo_replenished():
	ammoLabel.text = "%d/30" % [ammoCount]
	
	
func _on_ult_cooldown_timer_timeout():
	ultCooldown = null
	ultLabel.text = "READY"
	pass # Replace with function body.


func _on_unstoppable_pressed():
	ult = ULT.UNSTOPPABLE
	ultNameLabel.text = "UNSTOPPABLE FORCE"
	GameManager.isAugmentSelected = true
	get_tree().paused = false
	pass # Replace with function body.

func _on_dead_eye_pressed():
	print("deadeye")
	ult = ULT.DEADEYE
	ultNameLabel.text = "DEADEYE ARSENAL"
	GameManager.isAugmentSelected = true
	get_tree().paused = false
	pass # Replace with function body.

func _on_hyperdrive_pressed():
	ult = ULT.HYPERDRIVE
	ultNameLabel.text = "HYPERDRIVE PROTOCOL"
	GameManager.isAugmentSelected = true
	get_tree().paused = false



func _on_ult_duration_timer_timeout():
	setDefaultGunValues()


