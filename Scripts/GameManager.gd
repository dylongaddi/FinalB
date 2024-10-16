extends Node


# Called when the node enters the scene tree for the first time.
@export var pauseMenu: Control
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pauseMenu.show()
		get_tree().paused = true
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		get_tree().paused = false
		pauseMenu.hide()


func _on_settings_pressed():
	pass # Replace with function body.


func _on_resume_pressed():
	get_tree().paused = false
	pauseMenu.hide()
	pass # Replace with function body.


func _on_quit_pressed():
	pass # Replace with function body.
	


func _on_player_died():
	pass # Replace with function body.
