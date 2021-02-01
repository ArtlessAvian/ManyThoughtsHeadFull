extends Node
signal update_thought
signal new_thought
signal found_bad_thought
signal submit_good_thought
signal finish

export var thought_process : Resource
export var shuffle : bool = true

export var next_level : PackedScene

func goto_next_level():
	if next_level != null:
		get_tree().change_scene_to(next_level)
		self.queue_free()

var current_thought : String = ""
var all_thoughts : Array = []
var queued_thoughts : Array = []

export var first_level : bool

func _ready():
	randomize()
	requeue()
	
	if first_level:
		current_thought = "Lost and "
		emit_signal("update_thought", self, current_thought)

func requeue():
	timer = 5
	if thought_process != null:
		queued_thoughts = thought_process.thoughts.duplicate();
		if shuffle:
			queued_thoughts.shuffle()
		while len(all_thoughts) < 3 and not queued_thoughts.empty():
			pop_thought()

func pop_thought():
	if not queued_thoughts.empty():
		var popped = queued_thoughts.pop_back()
		all_thoughts.append(popped)
#		print(popped)
		emit_signal("new_thought", self, popped)

var timer = 5
func _physics_process(delta):
	timer -= delta
	if timer < 0:
		timer += randf() * 3 + 0.2
		pop_thought()

var control_a_last = false

#var delete_word = RegEx.new()
#delete_word.compile("(\\w+\\s+|\\W\\s+)")

func _input(event):
	if not (event is InputEventKey and event.pressed):
		return
	
	if OS.get_scancode_string(event.get_scancode_with_modifiers()) == "Control+A":
		control_a_last = true
	
	elif event.scancode == KEY_ENTER:
		input_enter(event)
	
	elif event.scancode == KEY_BACKSPACE:
		input_backspace(event)
	
	else:
		if control_a_last:
			current_thought = char(event.unicode)
			control_a_last = false
		else:
			current_thought = current_thought + char(event.unicode)
		if current_thought in all_thoughts:
			if current_thought != thought_process.good_thought:
				all_thoughts.erase(current_thought)
				emit_signal("found_bad_thought", self, current_thought)
				pop_thought()
	
	emit_signal("update_thought", self, current_thought)

func input_backspace(event):
	if control_a_last:
		current_thought = ""
		control_a_last = false
	elif OS.get_scancode_string(event.get_scancode_with_modifiers()) == "Control+BackSpace":
		while not current_thought.empty() and (current_thought.ends_with(" ") or current_thought.ends_with(".")):
			current_thought.erase(len(current_thought) - 1, 1)
		while not current_thought.empty() and not (current_thought.ends_with(" ") or current_thought.ends_with(".")):
			current_thought.erase(len(current_thought) - 1, 1)
	else:
		current_thought.erase(len(current_thought) - 1, 1)

func input_enter(event):
	if is_correct():
		emit_signal("submit_good_thought", self, current_thought)
		current_thought = ""
		all_thoughts.clear()
		queued_thoughts.clear()
		thought_process = thought_process.continuation
		self.requeue()
		if thought_process == null:
			emit_signal("finish")
			print("finish")

func is_correct():
	if thought_process == null or all_thoughts.empty():
		return false
	if not thought_process.good_thought in all_thoughts:
		return false
	return current_thought == thought_process.good_thought

func is_incorrect():
	if thought_process == null:
		return false
	for thought in all_thoughts:
		if thought.begins_with(current_thought):
			return false
	return true

func _on_Game_finish():
	$AnimationPlayer.play("Complete")

func _on_Game_update_thought():
	pass # Replace with function body.
