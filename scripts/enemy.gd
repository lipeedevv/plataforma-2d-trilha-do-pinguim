
extends CharacterBody2D

@export var speed: float = 35.0
@export var patrol_distance: float = 60.0
@export var damage: int = 1

var direction: int = 1
var start_position: Vector2

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var damage_area: Area2D = $DamageArea


func _ready() -> void:
	start_position = global_position
	sprite.play("walk")

	damage_area.collision_layer = 0
	damage_area.collision_mask = 2
	damage_area.monitoring = true

	damage_area.body_entered.connect(_on_damage_area_body_entered)

	print("Área de dano configurada!")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if global_position.x >= start_position.x + patrol_distance:
		direction = -1
	elif global_position.x <= start_position.x - patrol_distance:
		direction = 1

	if is_on_wall():
		direction *= -1

	velocity.x = direction * speed
	sprite.flip_h = direction < 0

	move_and_slide()


func _on_damage_area_body_entered(body: Node2D) -> void:
	print("Algo encostou no inimigo: ", body.name)

	if body is Player:
		print("PINGUIM DETECTADO! Aplicando dano.")
		body.take_damage(damage)
		print("Vida restante: ", body.health)
