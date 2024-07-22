extends Weapon

@onready var player = get_parent().get_node("Player")
var drop = preload("res://Characters/small_drop.tscn").instantiate()

func _init():
	speed = 900
	cooldown_step_size = 0.2
	recharge_speed = 0.3
	full_recharge_speed = 0.4
	fire_delay = 0.05
	range = 10000
	damage = 300

func _ready():
	$RayCast2D.add_exception(player)
	$RayCast2D.add_exception(drop)
	direction = Vector2.RIGHT.rotated(player.rotation)
	max_damage = damage

func _physics_process(delta):
	rotation = 0
	position += direction * speed * delta
	travelled_distance += speed * delta
	if $RayCast2D.is_colliding() and $RayCast2D.get_collider() != null and $RayCast2D.get_collider().is_in_group("Enemy"):
		direction = direction.bounce($RayCast2D.get_collision_normal())
	
	if travelled_distance > range:
		queue_free()

func hit(enemy_health):
	if enemy_health >= max_damage:
		queue_free()
	else:
		used = false
		max_damage -= enemy_health
		
