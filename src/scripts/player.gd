extends CharacterBody2D
class_name Player

# --- Statystki gracza ---
@export var movement_speed: float = 300 # Prędkość ruchu (można ją ustawić w edytorze)
@export var maxHealth = 100
@export var maxEXP = 100
@export var dmgToPlayer = 2
@onready var currHealth : int = maxHealth
@onready var progress_bar = $"../Stats/HPBar"
@onready var exp_bar = $"../Stats/EXPBar"
@onready var level: Label = $"../Stats/EXPBar/Level"
@onready var upgrade_screen = $"../CanvasLayer2"

func _ready():
	# Ukryj menu ulepszeń na początku
	upgrade_screen.visible = false

 # Ścieżka do HealthBar w scenie
var character_direction: Vector2
var is_in_area = false
var lvl = 1
var expMax = 100

var time: float = 0
var time_interval: float = 1.5 # Czas w sekundach, co ile będą zadawane obrażenia

# Scena bańki
@export var bubble_scene: PackedScene
var shoot_timer: float = 0.0


# Funkcja sprawdzająca kolizje
func _physics_process(delta):
	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("up", "down")
	character_direction = character_direction.normalized()
	
	if character_direction.x > 0:
		%sprite.flip_h = false
	elif character_direction.x < 0:
		%sprite.flip_h = true

	if character_direction:
		velocity = character_direction * movement_speed
		if %sprite.animation != "walk":
			%sprite.animation = "walk"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if %sprite.animation != "idle":
			%sprite.animation = "idle"
	
	if is_in_area:
		time += delta
		if time >= 1.5:
			take_damage(dmgToPlayer)
			progress_bar.value -= dmgToPlayer
			time = 0

	move_and_slide()
	
	# Logika strzelania
	shoot_timer += delta
	if shoot_timer >= time_interval:
		shoot_bubble()
		shoot_timer = 0.0
	
# Funkcja zmniejszająca zdrowie
func take_damage(damage: int):
	currHealth -= damage
	if currHealth <= 0:
		currHealth = 0
		get_tree().change_scene_to_file("res://scenes/gameOver.tscn")
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		is_in_area = true
		take_damage(dmgToPlayer)
		progress_bar.value -= dmgToPlayer
		time = 0
		
	if area.is_in_group("exp"):
		exp_bar.value += 20  # Dodaj doświadczenie do exp bara
		area.queue_free()    # Usuń obiekt EXP po kolizji
		
		if exp_bar.value >= 100:
			lvl += 1
			level.text = str(lvl)
			exp_bar.value = 0
			 # Ścieżka do menu
			upgrade_screen.visible = true
			get_tree().paused = true  # Zatrzymanie gry
			$LevelUp.play()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		is_in_area = false

func shoot_bubble():
	if not bubble_scene:
		return

	# Utwórz bańkę i ustaw jej pozycję
	var bubble = bubble_scene.instantiate() as Area2D
	bubble.position = global_position

	# Oblicz kierunek strzału (w kierunku myszy)
	var mouse_position = get_global_mouse_position()
	bubble.direction = (mouse_position - global_position).normalized()
	# Dodaj bańkę do sceny
	get_tree().get_current_scene().add_child(bubble)
	$BubbleShotAudio.play()

func _close_upgrade_screen():
	upgrade_screen.visible = false  # Ukryj ekran ulepszeń
	get_tree().paused = false  # Wznowienie gry

func increase_attack() -> void:
	upgrade_screen.visible = true
	var bubble = bubble_scene.instantiate() as Area2D
	if bubble.has_method("set_damage"):
		print("JEST")
		bubble.set_damage(bubble.get_damage())  # Zwiększ obrażenia bańki
	_close_upgrade_screen()

func increase_movement_speed() -> void:
	upgrade_screen.visible = true
	movement_speed += 50
	_close_upgrade_screen()

func increase_attack_speed() -> void:
	upgrade_screen.visible = true
	time_interval -= 0.2  # Szybszy atak
	_close_upgrade_screen()

func increase_max_hp() -> void:
	upgrade_screen.visible = true
	maxHealth += 20
	currHealth += 20
	progress_bar.value += 20
	_close_upgrade_screen()
