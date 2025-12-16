extends Node2D

@onready var player: Player = $Player
@onready var upgrade_screen = $CanvasLayer2/UpgradeScreen
var enemy = preload("res://scenes/enemy.tscn")
var camera: Camera2D
var spawn_interval: float = 1.3  # Czas między generowaniem przeciwników (w sekundach)
var time_since_last_spawn: float = 0.0  # Licznik czasu

func _ready() -> void:
	# Znajdź Player w hierarchii i z niego pobierz kamerę
	var player = get_node_or_null("Player")
	if player:
		camera = player.get_node_or_null("Camera2D")
		if not camera:
			push_error("Camera2D not found in Player!")
			return
	else:
		push_error("Player node not found in the scene!")
		return
	
func _physics_process(delta: float) -> void:
	time_since_last_spawn += delta
	if time_since_last_spawn >= spawn_interval:
		time_since_last_spawn = 0.0
		var pos = get_random_position_outside_camera()
		inst(pos)

func get_random_position_outside_camera() -> Vector2:
	var x_min = 18
	var x_max = 1262
	var y_min = 13
	var y_max = 702
	
	if not camera:
		return Vector2.ZERO
	
	# Oblicz prostokąt widoku kamery
	var camera_rect = Rect2(
		camera.position - camera.offset, 
		get_viewport().get_visible_rect().size / camera.zoom
	)

	var position = Vector2()
	while true:
		position.x = randi_range(x_min, x_max)
		position.y = randi_range(y_min, y_max)
		# Sprawdź, czy pozycja jest poza widokiem kamery
		if not camera_rect.has_point(position):
			break
	
	return position

func inst(pos: Vector2):
	var instance = enemy.instantiate()
	instance.position = pos
	add_child(instance)
	instance.add_to_group("enemy")  # Dodanie do grupy "enemy"
	
	# Ustawienie warstwy kolizji i maski kolizji
	if instance is CollisionObject2D:
		instance.collision_layer = 4  # Ustawienie warstwy kolizji na 4
		instance.collision_mask = 4   # Ustawienie maski kolizji na 4
	
	# Ustawienie visibility layer i visibility mask
	if instance.get_node_or_null("Sprite2D"):  # Jeśli istnieje Sprite2D w instancji
		var sprite = instance.get_node("Sprite2D")
		sprite.visibility_layer = 1   # Ustawienie visibility layer na 1
		sprite.visibility_mask = 1    # Ustawienie visibility mask na 1
