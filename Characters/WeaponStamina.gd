extends TextureProgressBar

var weapon_on_cooldown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if value == max_value:
		weapon_on_cooldown = false
		tint_progress = Color(1,1,1,1)
	if value == 0 or weapon_on_cooldown:
		tint_progress = Color(255,0,0,1)
		weapon_on_cooldown = true
		value += step * 1.5
	elif Input.is_action_pressed("left_click"):
		value -= step
	else:
		value += step
		
