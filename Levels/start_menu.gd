extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_stage_1_pressed():
	get_tree().change_scene_to_file("res://Levels/map.tscn")


func _on_stage_2_pressed():
	pass # Replace with function body.


func _on_stage_3_pressed():
	get_tree().change_scene_to_file("res://Levels/stage_3.tscn")


func _on_stage_4_pressed():
	pass # Replace with function body.
