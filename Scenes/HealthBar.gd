extends ProgressBar

@export var object:CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if object:
		object.healthChanged.connect(_on_health_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_health_changed():
	value = object.currentHealth * 100 / object.maxHealth
