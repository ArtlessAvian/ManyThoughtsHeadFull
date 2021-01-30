extends Control

const prototype : PackedScene = preload("res://view/Thought.tscn")
var contentToThought : Dictionary = {};

const springyness = 5

func _physics_process(delta):
	var increment = 1.0/(get_child_count() + 2)
	var accumulator = increment
	for thought in get_children():
		thought.anchor_top = (accumulator + thought.anchor_top * (springyness - 1)) / springyness
		thought.anchor_bottom = thought.anchor_top
		accumulator += increment

func _on_Game_new_thought(game, content):
	var copy : Label
	copy = prototype.instance()
	copy.setup(content)
	add_child(copy)
	
	var order = randi() % get_child_count();
	move_child(copy, order)
	copy.anchor_top = (order + 1) * 1.0/(get_child_count() + 2)
	copy.anchor_bottom = copy.anchor_top
	
	contentToThought[content] = copy

func _on_Game_found_bad_thought(game, content):
	var bad = contentToThought[content]
	bad.get_node("AnimationPlayer").play("Disappear")

func _on_Game_submit_good_thought(game, content):
	
