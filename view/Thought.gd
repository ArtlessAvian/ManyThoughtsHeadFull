extends Label

# Called when the node enters the scene tree for the first time.
func setup(content, color):
	self.text = "* " + content
	self.set("custom_colors/font_color", color)
#	rect_position.y = rect_size.y * -1/2
