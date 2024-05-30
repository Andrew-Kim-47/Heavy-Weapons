extends TextureProgressBar

func _ready():
	get_parent().get_parent().get_node("Player").health_changed.connect(update)
# Called when the node enters the scene tree for the first time.
func update():
	value = get_parent().get_parent().get_node("Player").health
