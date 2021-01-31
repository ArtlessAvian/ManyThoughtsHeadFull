extends Node

func _input(event):
	if not event is InputEventKey or event.is_echo():
		return
	
	if event.scancode == KEY_ENTER:
		if event.pressed:
			$backspace_down.play()
		else:
			$backspace_up.play()
	
	elif event.scancode == KEY_BACKSPACE:
		if event.pressed:
			$backspace_down.play()
		else:
			$backspace_up.play()
			
	elif event.scancode == KEY_SPACE:
		if event.pressed:
			$backspace_down.play()
		else:
			$backspace_up.play()
	
	elif char(event.scancode) == "":
		if event.pressed:
			$backspace_down.play()
		else:
			$backspace_up.play()
	
	else:
		if event.pressed:
			$keydown.get_child(randi() % 5).play()
		else:
			$keyup.play()
