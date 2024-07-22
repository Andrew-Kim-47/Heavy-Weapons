extends Control

@onready var map = get_parent().get_parent()
@onready var player = map.get_node("Player")
var weapon1 = Singleton.weapon1
var weapon2 = Singleton.weapon2
var weapon3 = Singleton.weapon3

var timer_started = false

func _ready():
	$Timer.wait_time = 5
	%Weapon1Stamina.in_use = true
	%Weapon1name.text = weapon1
	%Weapon1Stamina.weapon = player.weapon1
	%Weapon1Stamina.step = %Weapon1Stamina.weapon.cooldown_step_size
	if weapon2 == "none":
		%Weapon2Container.visible = false
	else:
		%Weapon2name.text = weapon2
		%Weapon2Stamina.weapon = player.weapon2
		%Weapon2Stamina.step = %Weapon2Stamina.weapon.cooldown_step_size
		
	if weapon3 == "none":
		%Weapon3Container.visible = false
	else:
		%Weapon3name.text = weapon3
		%Weapon3Stamina.weapon = player.weapon3
		%Weapon3Stamina.step = %Weapon3Stamina.weapon.cooldown_step_size
	
func _process(delta):
	%Score.text = "Kills: " + str(map.enemies_killed) + "/" + str(map.enemy_quota) + "\nCash: " + str(get_parent().get_parent().cash)
	if Input.is_action_pressed("1"):
		%Weapon1bar.self_modulate.a = 1
		%Weapon2bar.self_modulate.a = 0
		%Weapon3bar.self_modulate.a = 0
		%Weapon1Stamina.in_use = true
		%Weapon2Stamina.in_use = false
		%Weapon3Stamina.in_use = false
		player.cur_weapon_path = player.weapon1_path
		player.cur_weapon = player.weapon1
		player.cur_weapon_stamina = player.weapon1_stamina
	elif Input.is_action_pressed("2") and %Weapon2Container.visible:
		%Weapon1bar.self_modulate.a = 0
		%Weapon2bar.self_modulate.a = 1
		%Weapon3bar.self_modulate.a = 0
		%Weapon1Stamina.in_use = false
		%Weapon2Stamina.in_use = true
		%Weapon3Stamina.in_use = false
		player.cur_weapon_path = player.weapon2_path
		player.cur_weapon = player.weapon2
		player.cur_weapon_stamina = player.weapon2_stamina
		%Weapon2Stamina.in_use = true
	elif Input.is_action_pressed("3") and %Weapon3Container.visible:
		%Weapon1bar.self_modulate.a = 0
		%Weapon2bar.self_modulate.a = 0
		%Weapon3bar.self_modulate.a = 1
		%Weapon1Stamina.in_use = false
		%Weapon2Stamina.in_use = false
		%Weapon3Stamina.in_use = true
		player.cur_weapon_path = player.weapon3_path
		player.cur_weapon = player.weapon3
		player.cur_weapon_stamina = player.weapon3_stamina
		
	if map.is_ending and !timer_started:
		timer_started = true
		$Timer.start(5)
	if map.is_ending:
		$RichTextLabel.visible = true
		$RichTextLabel.text = "[center]Enemy quota destroyed\nDouble cash\n\nLevel ends in " + str(floor($Timer.time_left)) + " seconds"

