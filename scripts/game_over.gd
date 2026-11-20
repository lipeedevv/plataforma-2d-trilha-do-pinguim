extends CanvasLayer

const WIN_SOUND = preload("res://audio/vitoria.wav")

@onready var title: Label = $Painel/Card/Content/Title
@onready var description: Label = $Painel/Card/Content/Description
@onready var button: Button = $Painel/Card/Content/Button

var started := false

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	button.grab_focus()
	get_tree().paused = true

func mostrar() -> void:
	_show_result("Fim de jogo", "Volte ao início e tente outra vez.", "Tentar novamente")

func celebrate(player: Player) -> void:
	player.play_sound(WIN_SOUND)
	_show_result("Trilha concluída!", "Você encontrou todas as moedas.", "Jogar de novo")

func _show_result(heading: String, message: String, action: String) -> void:
	title.text = heading
	description.text = message
	button.text = action
	show()
	button.grab_focus()
	get_tree().paused = true

func _on_button_pressed() -> void:
	get_tree().paused = false
	if started:
		get_tree().reload_current_scene()
		return
	started = true
	hide()
