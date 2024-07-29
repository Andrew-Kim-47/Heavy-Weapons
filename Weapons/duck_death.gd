extends Weapon

var target

func _init():
	speed = 1000
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.1
	range = 1000
	damage = 500
	max_damage = 100000

func _physics_process(delta):
	rotation = 0
	var shortest_distance = 1280
	for enemy in map.get_tree().get_nodes_in_group("Enemy_target"):
		var distance = enemy.position.distance_to(get_global_mouse_position())
		if distance < shortest_distance:
			target = enemy
			shortest_distance = distance
			
	direction = (target.position - position).normalized()
	if position.distance_to(target.position) < 10:
		position = target.position
	else:
		position += direction * speed * delta
