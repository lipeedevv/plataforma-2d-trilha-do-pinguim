class_name Player extends CharacterBody2D

signal health_changed(current_health: int)

const SPEED: int = 100
const JUMP_VELOCITY: float = -300.0
const ANIMATION_IDLE: String = "idle"
const ANIMATION_WALK: String = "walk"
const ANIMATION_JUMP: String = "jump"
const MAX_JUMP_COUNT: int = 2
const FALL_DEATH_Y: float = 240.0
const JUMP_SOUND = preload("res://audio/pulo.wav")
const HURT_SOUND = preload("res://audio/dano.wav")
const DEFEAT_SOUND = preload("res://audio/derrota.wav")

# Sistema de vida
@export var max_health: int = 3
var health: int = 3
var invincible: bool = false
var dead: bool = false

var jump_count: int = 0

@onready var animated: AnimatedSprite2D = %AnimatedSprite2D
@onready var sound_effects: AudioStreamPlayer = $SoundEffects


func _ready() -> void:
	sound_effects.play()
	health = max_health
	add_to_group("player")
	health_changed.emit(health)


func _physics_process(delta: float) -> void:
	if dead:
		return

	# Gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0

	# Pulo duplo
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or jump_count < MAX_JUMP_COUNT):
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		play_sound(JUMP_SOUND)

	# Movimentação
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	_update_animations(direction)
	move_and_slide()

	if global_position.y > FALL_DEATH_Y:
		die()


func play_sound(sound: AudioStream) -> void:
	var playback := sound_effects.get_stream_playback() as AudioStreamPlaybackPolyphonic
	playback.play_stream(sound)


func _update_animations(direction: float) -> void:
	if not is_on_floor():
		animated.play(ANIMATION_JUMP)
		animated.flip_h = direction < 0
	else:
		if direction != 0:
			animated.play(ANIMATION_WALK)
			animated.flip_h = direction < 0
		else:
			animated.play(ANIMATION_IDLE)


# Receber dano
func take_damage(amount: int = 1) -> void:
	if invincible or dead:
		return

	health = max(health - amount, 0)
	health_changed.emit(health)

	if health <= 0:
		die()
		return

	play_sound(HURT_SOUND)
	invincible = true
	modulate.a = 0.5

	await get_tree().create_timer(1.0).timeout

	if not dead:
		modulate.a = 1.0
		invincible = false


# Recuperar vida
func heal(amount: int = 1) -> void:
	if dead:
		return

	health = min(health + amount, max_health)
	health_changed.emit(health)
	

# Morrer

func die() -> void:
	if dead:
		return

	dead = true
	play_sound(DEFEAT_SOUND)
	velocity = Vector2.ZERO
	health = 0
	health_changed.emit(health)

	var game_over = get_parent().get_node("GameOver")
	game_over.mostrar()
