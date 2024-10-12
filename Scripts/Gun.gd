extends Sprite2D
class_name Gun

var _bullet = preload("res://Scenes/bullet.tscn")
@onready var barrel = $Marker2D
@export var bobbing_amplitude: float = 0.0015  # How far the bobble goes
@export var bobbing_speed: float = 8  # How fast it bobs
@export var bobble = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_bobble(value):
	bobble = value

	
	var offset_y = sin(Time.get_ticks_msec() * bobbing_speed * 0.001) * bobbing_amplitude
	position.y += offset_y
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if bobble:
		var offset_y = sin(Time.get_ticks_msec() * bobbing_speed * 0.001) * bobbing_amplitude
		position.y += offset_y
	pass
	
func shoot(speed):
	var bullet = _bullet.instantiate()
	bullet.global_position = barrel.global_position  # Gun position

	# Calculate direction based on aim
	var direction = (get_global_mouse_position() - global_position).normalized()
	bullet.direction = direction

	# Add the bullet to the scene
	get_tree().current_scene.add_child(bullet)
