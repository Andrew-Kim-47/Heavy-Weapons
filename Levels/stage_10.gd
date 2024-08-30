extends Map

func _ready():
	$Turret.fire_delay = 0.5
	$Turret.projectile_type = "res://Characters/enemy_star.tscn"
	
	


func _on_saucer_spawn_timer_timeout():
	spawn_enemy("res://Characters/enemy_saucer.tscn")
