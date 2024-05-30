extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Grow")
	#await get_tree().create_timer(3).timeout
	#$AnimationPlayer.play("Shrink")
	#await get_tree().create_timer(1).timeout
	#queue_free()
	
func shrink():
	$AnimationPlayer.play("Shrink")
	await get_tree().create_timer(1).timeout
	queue_free()
	


