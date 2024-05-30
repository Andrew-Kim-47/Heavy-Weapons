extends Control

@onready var map = get_parent().get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%Score.text = "Kills: " + str(map.enemies_killed) + "/" + str(map.enemy_quota) + "\nCash: " + str(get_parent().get_parent().cash)
