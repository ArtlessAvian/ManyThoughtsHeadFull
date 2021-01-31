extends Control

const prototype : PackedScene = preload("res://view/Thought.tscn")
var contentToThought : Dictionary = {}
export var stuff : NodePath = "Control"
export var color : Color = Color.black

const springyness = 5

var batch = 0
var time = 0
var period_offset = []

func _physics_process(delta):
	var thing = get_node("Control")
	time += delta
	
	var increment = 1.0/(thing.get_child_count() + 1)
	for i in thing.get_child_count():
		var thought = thing.get_child(i)
		thought.anchor_top = (increment * (i+1) + thought.anchor_top * (springyness - 1)) / springyness
		thought.anchor_bottom = thought.anchor_top
		
		if thing.get_child_count() > 5:
			var wavey = sin(time/2 + period_offset[i]) * 10 + 10
			thought.margin_left = (wavey + thought.margin_left * (springyness - 1)) / springyness
			thought.margin_right = thought.margin_left


func _on_Game_new_thought(game, content):
	var local_batch = batch
	var copy : Label
	
	copy = prototype.instance()
	copy.setup(content, color)
	contentToThought[content] = copy
	
	if game != null:
		yield(get_tree().create_timer(randf() * 2 + 1), "timeout")
		if local_batch != batch:
			return
	
	var thing = get_node("Control")
	
	thing.add_child(copy)
	
	if game != null:
		var order = randi() % thing.get_child_count();
		thing.move_child(copy, order)
		copy.anchor_top = (order + 1) * 1.0/(thing.get_child_count() + 1)
		copy.anchor_bottom = copy.anchor_top
	
	if len(period_offset) < thing.get_child_count():
		period_offset.push_back(randf() * PI * 2)
		period_offset.shuffle()

func _on_Game_found_bad_thought(game, content):
	var bad = contentToThought[content]
	bad.get_node("AnimationPlayer").play("Disappear")
	contentToThought.erase(content)

func _on_Game_submit_good_thought(game, content):
	for key in contentToThought.keys():
		contentToThought[key].get_node("AnimationPlayer").play("Disappear")
		contentToThought.erase(key)
	batch += 1
