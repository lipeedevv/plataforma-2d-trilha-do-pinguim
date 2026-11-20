
extends Area2D

signal coin_collected

const PICKUP_SOUND = preload("res://audio/moeda.wav")

func _ready() -> void:
	collision_layer = 0
	collision_mask = 2
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.play_sound(PICKUP_SOUND)
		coin_collected.emit()
		queue_free()
