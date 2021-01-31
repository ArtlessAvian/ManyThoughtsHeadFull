extends Control

export var base_color : Color = Color.white;

func _ready():
	find_node("CurrentThought").base_color = base_color

func _on_Game_update_thought(game, content):
	find_node("CurrentThought")._on_Game_update_thought(game, content)

var series = 0
export var replies = [":o", "What he say", null,
		"Did you?", "Hindsight is 2020", null,
		"You wanted to talk more", null, null,
		"That's learning :P", null, "Oops\nWhen this is all over, it'll be easier in person", null
	]
	
func _on_Game_submit_good_thought(game, content):
	if series == 0:
		find_node("spacer").visible = true
	new_user_message(content)
	yield(get_tree().create_timer(1), "timeout")
	if replies[series] != null:
		new_other_message(replies[series])
	series += 1

func new_user_message(content):
	var copy = find_node("mychat").duplicate()
	copy.text = content
	find_node("messagelog").add_child(copy)
	find_node("Chatbox").raise()

func new_other_message(content):
	var copy = find_node("otherchat").duplicate()
	copy.text = content
	find_node("messagelog").add_child(copy)
	find_node("Chatbox").raise()
