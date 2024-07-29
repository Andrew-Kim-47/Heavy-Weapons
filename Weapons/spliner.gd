extends Weapon

@onready var player = get_parent().get_node("Player")
var cursor
var distance


func _init():
	speed = 900
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.1
	range = 10000
	damage = 20
	
	
func _physics_process(delta):
	rotation = 0
	position = player.position
	cursor = get_global_mouse_position()
	distance = player.position.distance_to(cursor) / 20
	var angle = (cursor - player.position).normalized() * distance
	var prev = player.position
	var osc = 1
	var count = 0
	var nodes = get_tree().get_nodes_in_group("Link")
	for link in nodes:
		link.oscillation = osc
		link.global_position = prev + angle
		prev = prev + angle
		if count < 10:
			osc += distance / 10
		else:
			osc -= distance / 10
		count += 1
			
		
		


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		area.get_parent().take_damage(damage)


func _on_timer_timeout():
	queue_free()
