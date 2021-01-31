extends Control

export var base_color : Color = Color.white;

func _ready():
	$Page/VBoxContainer/CurrentThought.base_color = base_color

func _on_Game_update_thought(game, content):
	$Page/VBoxContainer/CurrentThought._on_Game_update_thought(game, content)

func _on_Game_submit_good_thought(game, content):
	var copy = $Page/VBoxContainer/CurrentThought.duplicate()
	copy.set_script(null)
	copy.name = "good"
	copy.text = content
	copy.set("custom_colors/font_color", base_color)
	$Page/VBoxContainer.add_child(copy)
	$Page/VBoxContainer.move_child(copy, $Page/VBoxContainer.get_child_count() - 2)
