extends Area2D

@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var label = $Label
var onCooldown: bool
signal ammo_replenished
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if onCooldown:
		label.text = "%d" % ammo_cooldown()
	pass

func ammo_cooldown():
	var time_left = timer.time_left
	var second = int(time_left) % 60
	return second
	
func _on_body_entered(body):
	if timer.is_stopped():
		if body is Player:
			body.ammoCount = 30
			sprite.hide()
			timer.start()
			label.show()
			ammo_replenished.emit()
			onCooldown = true
			

func _on_timer_timeout():
	sprite.show()
	label.hide()
	onCooldown = false
