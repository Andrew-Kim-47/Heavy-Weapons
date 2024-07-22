extends Area2D

var worth = 1

func _physics_process(_delta):
	%Shadow.global_position = global_position + Vector2(0, 6)
	%Shadow.rotation = 0
	$AnimationPlayer.play("Idle")

func _on_area_entered(area):
	if area.is_in_group("Player"):
		get_parent().cash += worth
		queue_free()
	 # Replace with function body.
