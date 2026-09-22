extends Node

@export var selection_visual: Sprite2D

func toggle_selection_visual(toggle: bool):
	selection_visual.visible = toggle
