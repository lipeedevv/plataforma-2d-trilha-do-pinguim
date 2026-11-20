extends Area2D

const PICKUP_SOUND = preload("res://audio/coracao.wav")

func _on_body_entered(body: Node2D) -> void:
	if body is Player and not body.dead and body.health < body.max_health:
		body.heal(1)
		body.play_sound(PICKUP_SOUND)
		queue_free()
