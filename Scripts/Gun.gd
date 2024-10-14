extends Sprite2D
class_name Gun

var _bullet = preload("res://Scenes/bullet.tscn")
@onready var barrel = $Marker2D
@onready var firerateTimer = $FirerateTimer
@export var bullet_speed: float
@export var player: Player
var can_shoot: bool = true
var gun_direction
var ammoCount
# Called when the node enters the scene tree for the first time.
	

func shoot():

	var direction = (get_global_mouse_position() - global_position).normalized()
	var bullet = _bullet.instantiate()
	bullet.direction = direction
	gun_direction = direction.angle()
	bullet.global_position = barrel.global_position  
	bullet.rotation = gun_direction
	bullet.speed = bullet_speed
	ammoCount = player.ammoCount
	if ammoCount > 0:
		get_tree().current_scene.add_child(bullet)
		firerateTimer.start()
