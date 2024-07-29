extends Weapon

@onready var player = get_parent().get_node("Player")

var target
var shortest_distance = 1280

var second_time = false

func _ready():
	for enemy in map.get_tree().get_nodes_in_group("Enemy_target"):
		var distance = enemy.position.distance_to(get_global_mouse_position())
		if distance < shortest_distance:
			target = enemy
			shortest_distance = distance
	if target == null:
		queue_free()
	else:
		look_at(target.position)
		var ratio = position.distance_to(target.position) / 1000
		$Sprite2D.scale.x = ratio
		$Sprite2D.scale.y = 0.01

func _physics_process(delta):
	position = player.position
	if target != null:
		look_at(target.position)


func _on_timer_timeout():
	$Sprite2D.scale.y = 0.1
	if !second_time and target != null:
		target.take_damage(1000)
	else:
		queue_free()
	second_time = true
