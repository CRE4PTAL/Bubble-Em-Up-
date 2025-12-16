extends VBoxContainer

@onready var player: Player = $"../../../Player"  # Upewnij się, że to jest instancja Player, a nie CharacterBody2D
@onready var upgrade_screen = $"../.."  # Poprawna ścieżka do UpgradeScreen

func close_menu():
	get_tree().paused = false  # Wznowienie gry
	upgrade_screen.visible = false

func _on_increase_attack_focus_entered() -> void:
	upgrade_screen.visible = true
	player.increase_attack()
	close_menu()

func _on_increase_speed_focus_entered() -> void:
	upgrade_screen.visible = true
	player.increase_movement_speed()
	close_menu()

func _on_increase_attack_speed_focus_entered() -> void:
	upgrade_screen.visible = true
	player.increase_attack_speed()
	close_menu()

func _on_increase_hp_focus_entered() -> void:
	upgrade_screen.visible = true
	player.increase_max_hp()
	close_menu()
