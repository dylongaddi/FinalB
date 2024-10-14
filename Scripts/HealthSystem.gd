extends Resource
class_name HealthSytstem

# Define the common properties and signals
signal healthChanged

@export var maxHealth: int = 100
@export var currentHealth: int = 100

# Implement common health-related methods
func take_damage(amount: int):
	currentHealth = max(currentHealth - amount, 0)
	emit_signal("healthChanged")

func heal(amount: int):
	currentHealth = min(currentHealth + amount, maxHealth)
	emit_signal("healthChanged")
