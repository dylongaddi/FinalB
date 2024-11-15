extends Sprite2D
class_name Gun

var _bullet = preload("res://Scenes/bullet.tscn")
@onready var barrel = $Marker2D
@onready var firerateTimer = $FirerateTimer
@export var bullet_speed: float = 1000.0
@export var player: Player
var can_shoot: bool = true
var gun_direction
@export var ammoCount: int
@export var damage: int
@export var critChance: float = 0.1
var critResult
# Called when the node enters the scene tree for the first time.

func shoot():
	var direction = (get_global_mouse_position() - global_position).normalized()
	var bullet = _bullet.instantiate()
	
	critResult = randf()
	if critResult < 0.2:
		damage = 20
	else:
		damage = 10
	bullet.damage = damage
	bullet.direction = direction
	gun_direction = direction.angle()
	bullet.global_position = barrel.global_position  
	bullet.rotation = gun_direction
	bullet.speed = bullet_speed
	ammoCount = player.ammoCount
	if ammoCount > 0:
		get_tree().current_scene.add_child(bullet)
	firerateTimer.start()
