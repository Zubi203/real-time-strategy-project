extends Panel

@export var end_screen_text: Label

func _ready() -> void:
	EventBus.GameWon.connect(_set_screen_text)

func _set_screen_text(team_name: String):
	if end_screen_text:
		end_screen_text.text = team_name + " team has won!"
	visible = true


func _on_menu_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
