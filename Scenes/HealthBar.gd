extends ProgressBar

@export var object:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if object:
		object.healthChanged.connect(_on_health_changed)
	pass # Replace with function body.


	
func _on_health_changed():
	if object.currentHealth < 0:
		return
	value = object.currentHealth
