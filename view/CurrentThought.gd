extends Label

func _on_Game_update_thought(game, content):
	self.text = content
	
	if game.is_correct():
		self.self_modulate = Color.green
	elif game.is_incorrect():
		self.self_modulate = Color.red
	else:
		self.self_modulate = Color.white
