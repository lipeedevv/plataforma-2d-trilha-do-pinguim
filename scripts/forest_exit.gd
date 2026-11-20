extends Area2D

@onready var hud = get_parent().get_node("HUD")
@onready var result = get_parent().get_node("GameOver")

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	hud.coins_changed.connect(queue_redraw)

func _draw() -> void:
	var accent := Color("#8deac6") if hud.all_coins_collected() else Color("#e6b76c")
	draw_rect(Rect2(-12, -29, 24, 29), Color("#172432"))
	draw_rect(Rect2(-10, -27, 20, 25), accent, false, 2)
	draw_rect(Rect2(-8, -25, 16, 22), accent.darkened(0.76))
	draw_colored_polygon(PackedVector2Array([Vector2(-5, -16), Vector2(0, -16), Vector2(0, -19), Vector2(6, -14), Vector2(0, -9), Vector2(0, -12), Vector2(-5, -12)]), accent)
	draw_rect(Rect2(-14, -2, 28, 2), accent.darkened(0.22))

func _on_body_entered(body: Node2D) -> void:
	if body is Player and not body.dead and hud.all_coins_collected():
		result.celebrate(body)
