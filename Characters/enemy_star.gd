extends Projectile

func _init():
	damage = 15
	speed = 200

func _ready():
	$AnimationPlayer.play("Spin")

