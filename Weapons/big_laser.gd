extends Weapon

@onready var player = get_parent().get_node("Player")
var player_original_rotation
var original_rotation
var cooldown_bar

func _init():
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.1
	range = 1000
	damage = 500
	max_damage = 100000

func _ready():
	player_original_rotation = player.rotation
	original_rotation = rotation
	
func _physics_process(delta):
	position = player.position
	rotation = original_rotation + player.rotation - player_original_rotation
	if Input.is_action_just_released("left_click") or cooldown_bar.weapon_on_cooldown:
		print('s')
		queue_free()
