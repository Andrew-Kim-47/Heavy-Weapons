extends TextureProgressBar

func _ready():
	get_parent().health_changed.connect(update)
# Called when the node enters the scene tree for the first time.
func update():
	value = get_parent().health
	print(value)
	if !visible:
		visible = true
		await get_tree().create_timer(1).timeout
		visible = false

func _physics_process(delta):
	rotation = -get_parent().rotation
	if value < 30 and is_in_group("Player"):
		visible = true
