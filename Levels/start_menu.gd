extends Control

@onready var group = %stage_1.button_group

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_button_press():
	var stage_number = group.get_pressed_button()
	get_tree().change_scene_to_file("res://Levels/" + stage_number.name + ".tscn")


func _on_shop_pressed():
	get_tree().change_scene_to_file("res://Levels/shop.tscn")
