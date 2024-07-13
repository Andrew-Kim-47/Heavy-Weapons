extends Control

@onready var group = %shot.button_group
@onready var buy_window = $BuyWindow
@onready var question = preload("res://Art/question.png")

var selected_weapon
var selected_button

var dict = {
	"shot": "Shoots one laser bolt at a time and has a quick rate of fire.",
	"boomeranger": "An energy weapon which always comes back. If you miss the weapon will hone back in on your position giving you 2 attempts to take out the enemy. \n \n 2500"
}

var already_bought_dict = {
	"shot": true,
	"boomeranger": false
}

var cash_dict = {
	"shot": 0,
	#"diagonals": 2500,
	"boomeranger": 2500,
	#"arc_spread": 4000,
	#"spiraller": 5500,
	#"ricochet": 5500,
	#"spliner": 10000,
	#"4 homers": 15000,
	
}
# Called when the node enters the scene tree for the first time.
func _ready():
	check_prices()


func check_prices():
	for weapon in cash_dict:
		if Singleton.cash < cash_dict[weapon]:
			var button = get_node("%" + weapon)
			button.get_node("TextureRect").texture = question
			button.get_node("RichTextLabel2").text = "[center]CANT AFFORD[/center]"
			button.disabled = true
	%Cash.text = "[center]Cash: " + str(Singleton.cash) + "[/center]"
#Function for all weapon buttons
func _on_button_pressed():
	selected_button = group.get_pressed_button()
	selected_weapon = selected_button.name
	if already_bought_dict[selected_weapon]:
		$AllocateWindow.visible = true
	else:
		$BuyWindow/Name.text = selected_weapon
		$BuyWindow/Details.text = dict[selected_weapon]
		buy_window.visible = true
		


func _on_buy_button_pressed():
	buy_window.visible = false
	already_bought_dict[selected_weapon] = true
	Singleton.cash -= cash_dict[selected_weapon]
	check_prices()
	$AllocateWindow.visible = true


func _on_x_button_pressed():
	buy_window.visible = false


func _on_allocate_x_button_pressed():
	$AllocateWindow.visible = false


func _on_slot_1_pressed():
	Singleton.weapon1 = selected_weapon
	$TextureRect/HBoxContainer/Weapon1/TextureRect.texture = selected_button.get_node("TextureRect").texture
	$TextureRect/HBoxContainer/Weapon1/Name.text = "[center]" + selected_weapon + "[/center]"
	$AllocateWindow.visible = false


func _on_slot_2_pressed():
	Singleton.weapon2 = selected_weapon
	$TextureRect/HBoxContainer/Weapon2/TextureRect.texture = selected_button.get_node("TextureRect").texture
	$TextureRect/HBoxContainer/Weapon2/Name.text = "[center]" + selected_weapon + "[/center]"
	$AllocateWindow.visible = false


func _on_slot_3_pressed():
	Singleton.weapon3 = selected_weapon
	$TextureRect/HBoxContainer/Weapon3/TextureRect.texture = selected_button.get_node("TextureRect").texture
	$TextureRect/HBoxContainer/Weapon3/Name.text = "[center]" + selected_weapon + "[/center]"
	$AllocateWindow.visible = false


func _on_continue_pressed():
	get_tree().change_scene_to_file("res://Levels/start_menu.tscn")
