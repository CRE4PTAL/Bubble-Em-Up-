extends Area2D
@export var speed: float = 400.0
@export var damage: int = 30  # Ilość obrażeń zadawanych wrogowi
var is_done = false

var direction: Vector2 = Vector2.ZERO

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage

func _physics_process(delta: float) -> void:
	# Porusz bańkę w zadanym kierunku
	position += direction * speed * delta
	
	if is_done == true: 
		if %AnimatedSprite2D.animation != "destroy":
			%AnimatedSprite2D.animation = "destroy"
	
	# Usuń bańkę, jeśli wyjdzie poza ekran
	if not get_viewport_rect().has_point(position):
		queue_free()


# Funkcja wykrycia kolizji
func _on_area_entered(area: Area2D) -> void:
	# Jeśli obiekt należy do grupy "enemy", sprawdź, czy to instancja CharacterBody2D
	if area.is_in_group("enemy"):
		var enemy = area.get_parent()  # Pobierz rodzica (CharacterBody2D)
		if enemy and enemy.has_method("take_damage"):  # Sprawdź, czy ma metodę take_damage
			enemy.take_damage(damage)  # Wywołaj metodę zadawania obrażeń
			is_done = true	
		
		queue_free()  # Usuń bańkę po zderzeniu
		
