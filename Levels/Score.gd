extends Label


# Called when the node enters the scene tree for the first time.
var map = get_node("../../../../")
func _process(delta):
	self.text = str(get_parent().get_parent().get_parent().get_parent().enemies_killed)


