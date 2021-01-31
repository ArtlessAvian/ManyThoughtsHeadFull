#extends "res://Game.gd"
#
#func _ready():
#	emit_signal("new_thought", self, "Play")
#	emit_signal("new_thought", self, "Credits")
#	emit_signal("new_thought", self, "Quit")
#
#func is_valid():
#	if current_thought in ["Play", "Quit"]:
#		return true
#	return false
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass
