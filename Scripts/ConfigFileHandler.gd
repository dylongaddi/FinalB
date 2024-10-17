extends Node

var cfg = ConfigFile.new()
const SETTINGS_FILE_PATH = "res://settings.ini"

func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		cfg.set_value("audio", "volume", 1.0)
		
		cfg.save(SETTINGS_FILE_PATH)
	else:
		cfg.load(SETTINGS_FILE_PATH)

func save_settings(key: String, value):
	cfg.set_value("audio", key, value)
	cfg.save(SETTINGS_FILE_PATH)
	
func load_settings():
	var settings = {}
	for key in cfg.get_section_keys("audio"):
		settings[key] = cfg.get_value("audio", key)
	return settings
