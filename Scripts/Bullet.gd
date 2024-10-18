extends RigidBody2D
class_name Bullet

# Called when the node enters the scene tree for the first time.
@export var velocity:Vector2
@export var duration = 200
@onready var sprite = $Sprite2D
@onready var damageNumber = preload("res://Scenes/damage_number.tscn")

var damage = 1
var direction = Vector2.RIGHT
var speed = 0.0


func _physics_process(delta):
	velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	
	if collision:
		var entity = collision.get_collider()
		if entity is Boss:
			entity.take_damage(damage)
			var d = damageNumber.instantiate()
			d.label_settings = LabelSettings.new()
			if damage > 10:
				d.label_settings.font_color = Color(255, 255, 0)
			d.global_position = global_position
			d.text = str(damage)
			d.label_settings.outline_color = "#000"
			d.label_settings.outline_size = 6
			get_tree().current_scene.add_child(d)
		queue_free()
			
		
	duration -= 1
	if duration < 0:
		queue_free()
	
		
	
	
