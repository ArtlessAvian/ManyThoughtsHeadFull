extends Node
signal update_thought
signal new_thought
signal found_bad_thought
signal submit_good_thought

var current_thought : String = ""
var all_thoughts : Array = []
var bad_thoughts : Array = []

func _ready():
	add_thought("Butts")
	add_thought("Hello")
	add_thought("The quick brown fox")
	add_thought("jumps over the lazy dog", false)

func add_thought(content, is_bad = true):
	all_thoughts.append(content)
	if is_bad:
		bad_thoughts.append(content)
	emit_signal("new_thought", self, content)

func _input(event):
	if not (event is InputEventKey and event.pressed):
		return
	
	if event.scancode == KEY_ENTER:
		if is_correct():
			emit_signal("submit_good_thought", current_thought)
			current_thought = ""
	
	if event.scancode == KEY_BACKSPACE:
		current_thought.erase(len(current_thought) - 1, 1)
	
	else:
		current_thought = current_thought + char(event.unicode)
		for bad_thought in bad_thoughts:
			if bad_thought == current_thought:
				all_thoughts.erase(bad_thought)
				emit_signal("found_bad_thought", self, bad_thought)
	
	emit_signal("update_thought", self, current_thought)

func is_correct():
	for thought in all_thoughts:
		if thought == current_thought:
			return true
	return false

func is_incorrect():
	for thought in all_thoughts:
		if thought.begins_with(current_thought):
			return false
	return true


func _on_AllThoughts_valid_update():
	pass # Replace with function body.
