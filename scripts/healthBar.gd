extends ProgressBar

@onready var progress_bar = $HPBar

# Funkcja do aktualizacji paska zdrowia
func update_health(current_health: int, max_health: int):
	progress_bar.value = current_health
	progress_bar.max_value = max_health
