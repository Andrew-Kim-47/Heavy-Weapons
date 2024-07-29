extends Weapon


func _init():
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.2
	fire_delay = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	map.slow_time = true
	map.get_tree().call_group("Enemy_target", "slow_time")
	
func _physics_process(delta):
	pass


func _on_timer_timeout():
	map.slow_time = false
	map.get_tree().call_group("Enemy_target", "reset_time")
	queue_free()
