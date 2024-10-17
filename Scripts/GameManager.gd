extends Node


# Called when the node enters the scene tree for the first time.
@export var pauseMenu: Control
@export var mainMenu: PackedScene
@export var settings: Control
@export var gameOverScreen: Control
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pauseMenu.show()
		get_tree().paused = true
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		get_tree().paused = false
		pauseMenu.hide()


func _on_settings_pressed():
	if pauseMenu.visible:
		pauseMenu.hide()
	if not settings.visible:
		settings.show()
	pass # Replace with function body.


func _on_resume_pressed():
	get_tree().paused = false
	if pauseMenu.visible:
		pauseMenu.hide()
	if settings.visible:
		settings.hide()


func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
	


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(mainMenu)


func _on_boss_died():
	gameOverScreen.check_win(true)
	gameOverScreen.show()



func _on_player_died():
	gameOverScreen.check_win(false)
	gameOverScreen.show()

