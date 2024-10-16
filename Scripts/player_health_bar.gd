extends HBoxContainer

@export var player: Player
@onready var currentHeart = $PlayerHeart3
var currentHealth: float

func ready():
	currentHealth = player.currentHealth


func _on_player_health_changed():
	currentHealth = player.currentHealth

	if currentHealth >= 2.0:
		currentHeart = $PlayerHeart3
	elif currentHealth <= 2.0 and currentHealth >= 1.0:
		currentHeart = $PlayerHeart2
	else:
		currentHeart = $PlayerHeart
	if currentHealth == 2.5 or currentHealth == 1.5 or currentHealth == 0.5:
		currentHeart.update_sprite(0.5)
	elif currentHealth == 2.0 or currentHealth == 1.0 or currentHealth == 0.0:
		currentHeart.update_sprite(0.0)
	else:
		currentHeart.update_sprite(1)
