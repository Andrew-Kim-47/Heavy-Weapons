extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/Totals.text = "Total Kills: " + str(Singleton.total_kills) + "    Total Cash:" + str(Singleton.cash)
	$Panel/Level_complete.text = "Level 1 Complete"
	$Panel/Level_stats.text = "You killed  " + str(Singleton.level_kills) + " enemies and earned $" + str(Singleton.level_cash)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Levels/start_menu.tscn")
