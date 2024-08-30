extends TextureProgressBar

@onready var parent = get_parent()

func _ready():
	parent.health_changed.connect(update)
	max_value = parent.max_health
	value = max_value
# Called when the node enters the scene tree for the first time.
func update():
	value = parent.health
	if !visible:
		visible = true
		await get_tree().create_timer(1).timeout
		visible = false

func _physics_process(delta):
	rotation = -parent.rotation
	if value < 30 and is_in_group("Player_health"):
		visible = true
