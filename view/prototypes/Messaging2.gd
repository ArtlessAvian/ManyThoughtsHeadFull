extends Control

export var base_color : Color = Color.white;
# Easier than hardcoding!!!
export var current_path : NodePath
var current : Node

func _ready():
	current = get_node(current_path)
	current.base_color = base_color

func _on_Game_update_thought(game, content):
	current._on_Game_update_thought(game, content)

func _on_Game_submit_good_thought(game, content):
	var marginbox = $HBoxContainer/Chat/MarginContainer/VBoxContainer/Message9
	marginbox.visible = true
	var label = marginbox.get_node("HBoxContainer/Label12")
	label.text = label.text + "\n" + content
