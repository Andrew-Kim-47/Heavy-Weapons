extends Enemy

var enemy_type = "res://Characters/enemy_straight.tscn"
var spawn_number = 10

func _init():
	health = 1000

func _ready():
	_on_spawn_timer_timeout()
	
func _physics_process(delta):
	pass

func _on_spawn_timer_timeout():
	$AnimatedSprite2D.play("Open")
	await get_tree().create_timer(1).timeout
	for i in range(spawn_number):
		var enemy = load(enemy_type).instantiate()
		enemy.position = position
		get_parent().add_child(enemy)
		await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.play("Close")
