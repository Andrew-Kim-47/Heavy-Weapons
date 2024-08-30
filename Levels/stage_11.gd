extends Map

var random_progress
@onready var path = $Path2D/PathFollow2D

func _on_worm_spawn_timer_timeout():
	random_progress = randf()
	path.progress_ratio = random_progress
	var enemy_worm = load("res://Characters/enemy_worm.tscn").instantiate()
	enemy_worm.global_position = path.global_position
	if random_progress < 0.18:
		enemy_worm.rotation = 90 + 45 * randi_range(-1, 1)
	elif random_progress < 0.5:
		enemy_worm.rotation = 45 * randi_range(-1, 1)
	elif random_progress < 0.68:
		enemy_worm.rotation = -90 + 45 * randi_range(-1, 1)
	else:
		enemy_worm.rotation = -90 + 45 * randi_range(-1, 1)
	add_child(enemy_worm)



func _on_speeder_spawn_timer_timeout():
	spawn_enemy("res://Characters/enemy_speeder.tscn", 2, 2, 0.5)


func _on_enemy_spawn_timer_timeout():
	spawn_enemy("res://Characters/enemy_speeder.tscn", 2, 2, 0.5)


func _on_big_spawn_timer_timeout():
	spawn_enemy("res://Characters/enemy_big.tscn", 2, 2, 0.5)


func _on_crab_spawn_timer_timeout():
	spawn_enemy("res://Characters/enemy_crab.tscn", 2, 2, 0.5)


func _on_saucer_spawn_timer_timeout():
	spawn_enemy("res://Characters/enemy_saucer.tscn", 2, 2, 0.5)
