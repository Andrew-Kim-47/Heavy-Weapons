extends Map


func _on_crab_spawn_timer_timeout():
	spawn_enemy("res://Characters/enemy_crab.tscn", 3, 3, 0.5)
