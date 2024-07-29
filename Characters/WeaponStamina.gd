extends TextureProgressBar

var weapon_on_cooldown = false
var weapon
var in_use = false
var use_up = false
signal one_shot_recharged

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if value == max_value and weapon_on_cooldown:
		one_shot_recharged.emit()
	if value == max_value:
		weapon_on_cooldown = false
		tint_progress = Color(1,1,1,1)
	if value == 0 or weapon_on_cooldown:
		use_up = false
		tint_progress = Color(255,0,0,1)
		weapon_on_cooldown = true
		value += weapon.full_recharge_speed
	elif use_up or (Input.is_action_pressed("left_click") and in_use):
		value -= weapon.cooldown_step_size
	else:
		value += weapon.recharge_speed
		
		
