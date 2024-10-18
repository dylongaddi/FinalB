extends Control

@onready var volumeSlider = $HBoxContainer/Volume
# Called when the node enters the scene tree for the first time.
func _ready():
	var settings = ConfigFileHandler.load_settings()
	volumeSlider.value = min(settings.volume, 1.0) * 100

func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)



func _on_quit_pressed():
	get_tree().quit()


func _on_volume_drag_ended(value_changed):
	if value_changed:
		ConfigFileHandler.save_settings("volume", volumeSlider.value / 100)

