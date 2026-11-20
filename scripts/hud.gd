extends CanvasLayer

signal coins_changed

const HEART = preload("res://sprites/heart.png")
const COIN = preload("res://sprites/coin.png")

var moedas := 0
var coin_goal := 0

@onready var hearts: HBoxContainer = $Bar/Row/Hearts
@onready var coin_icon: TextureRect = $Bar/Row/CoinIcon
@onready var coin_count: Label = $Bar/Row/CoinCount
@onready var objective: Label = $Bar/Row/Objective

func _ready() -> void:
	var player: Player = get_parent().get_node("Player")
	for index in range(player.max_health):
		var icon := TextureRect.new()
		icon.texture = HEART
		icon.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		hearts.add_child(icon)
	coin_icon.texture = COIN
	player.health_changed.connect(_on_health_changed)
	_on_health_changed(player.health)

	for child in get_parent().get_children():
		_connect_coin(child)
	get_parent().child_entered_tree.connect(_connect_coin)
	_update_coins()

func all_coins_collected() -> bool:
	return moedas >= coin_goal

func _on_health_changed(health: int) -> void:
	for index in range(hearts.get_child_count()):
		var icon := hearts.get_child(index) as TextureRect
		icon.modulate.a = 1.0 if index < health else 0.25

func _update_coins() -> void:
	coin_count.text = "%d/%d" % [moedas, coin_goal]
	objective.text = "Vá até a saída" if all_coins_collected() else "Colete as moedas"
	objective.modulate = Color("#a6f3cd") if all_coins_collected() else Color("#f6d892")
	coins_changed.emit()

func _on_coin_collected() -> void:
	moedas += 1
	_update_coins()

func _connect_coin(node: Node) -> void:
	if node.has_signal("coin_collected"):
		node.connect("coin_collected", _on_coin_collected)
		coin_goal += 1
		_update_coins()
