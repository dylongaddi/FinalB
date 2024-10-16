extends Control

@onready var main = $Main
@onready var settings = $Settings
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/battle.tscn")
	pass # Replace with function body.


func _on_settings_pressed():
	main.hide()
	settings.show()
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
