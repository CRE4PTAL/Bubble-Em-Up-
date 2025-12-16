extends CharacterBody2D
class_name Enemy

@export var speed: float = 80.0  # Prędkość poruszania się wroga
@export var health: int = 40
@export var exp_scene: PackedScene  # Scena EXP
@onready var player = $"../Player"  # Ścieżka do obiektu gracza (dostosuj w razie potrzeby)

func _physics_process(delta: float) -> void:
	if not player or not player.is_inside_tree():
		return  # Sprawdź, czy gracz istnieje w scenie

	# Oblicz wektor kierunku
	var direction = (player.global_position - global_position).normalized()
	
	# Porusz wroga w kierunku gracza
	velocity = direction * speed
	move_and_slide()

func take_damage(damage: int):
	health -= damage
	if health <= 0:
		spawn_exp()  # Wywołaj funkcję spawnującą EXP
		queue_free()  # Usuń wroga po śmierci

func spawn_exp():
	if exp_scene:  # Sprawdź, czy scena EXP jest przypisana
		var exp_instance = exp_scene.instantiate()  # Utwórz instancję sceny
		exp_instance.position = global_position  # Ustaw pozycję EXP w miejscu wroga
		get_tree().get_current_scene().add_child(exp_instance)  # Dodaj do sceny
		exp_instance.add_to_group("exp")
