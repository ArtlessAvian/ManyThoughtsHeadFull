extends "res://Game.gd"

func is_correct():
	if thought_process == null:
		return false
	return len(current_thought) + 5 >= len(thought_process.thoughts[0])

func is_incorrect():
	return false
