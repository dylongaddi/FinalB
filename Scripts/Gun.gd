extends Sprite2D
class_name Gun

var _bullet = preload("res://Scenes/bullet.tscn")
@onready var barrel = $Marker2D
@onready var firerateTimer = $FirerateTimer
@export var bullet_speed: float
var can_shoot: bool = true
var gun_direction
# Called when the node enters the scene tree for the first time.
	
func shoot():
	var bullet = _bullet.instantiate()
	bullet.global_position = barrel.global_position  # Gun position
	bullet.speed = bullet_speed
	# Calculate direction based on aim
	var direction = (get_global_mouse_position() - global_position).normalized()
	bullet.direction = direction
	gun_direction = direction.angle()
	

	# Add the bullet to the scene
	get_tree().current_scene.add_child(bullet)
	firerateTimer.start()
