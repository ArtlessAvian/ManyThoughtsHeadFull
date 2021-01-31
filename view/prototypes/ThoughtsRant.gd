extends NinePatchRect

func _physics_process(delta):
	if get_parent().thought_process != null:
		var position = len(get_parent().current_thought)
		var rant = get_parent().thought_process.thoughts[0]
#		var space = rant.findn(" ", position)
#		var period = rant.findn(".", position)
#		var substring = rant.substr(position, space - position)
#		var substring = rant.substr(position, min(10000, space) - position)
		$Control.get_child(0).text = rant.substr(position, 7)
