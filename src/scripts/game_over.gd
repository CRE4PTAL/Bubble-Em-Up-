extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Game.tscn")

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
