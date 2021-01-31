extends Label

var base_color = Color.white
var blink_period = 0.5
var cursor_blink = blink_period
var last_text = ""
var incorrect = false

func _process(delta):
	if cursor_blink < -blink_period:
		cursor_blink = blink_period
		self.text = last_text
	elif cursor_blink < 0:
		self.text = last_text + "_"
	cursor_blink -= delta

func _on_Game_update_thought(game, content):
	self.text = content
	self.last_text = content
	cursor_blink = blink_period
	
	$Offset/Check.visible = false
	$Offset/Cross.visible = false
	if game.is_correct():
		self.set("custom_colors/font_color", Color.green)
		$Offset/Check.visible = true
	elif game.is_incorrect():
		self.set("custom_colors/font_color", Color.red)
		$Offset/Cross.visible = true
	else:
		self.set("custom_colors/font_color", base_color)
