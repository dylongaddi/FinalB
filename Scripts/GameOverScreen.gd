extends Control
class_name GameOverScreen

@onready var text = $HBoxContainer/Label

var win: bool

func checkWin(result):
	win = result
	if win:
		text.text = "You won!"
	else:
		text.text = "You died!"
		



func _on_restart_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/battle.tscn")


func _on_main_menu_pressed():
	if get_tree().paused == true:
		get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
