extends Panel

var value = 1
@onready var sprite = $Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_sprite(_value: float):
	value = _value
	if value == 1.0:
		sprite.frame = 0
	elif value == 0.5:
		sprite.frame = 2
	elif value <= 0.0:
		sprite.frame = 4
		

