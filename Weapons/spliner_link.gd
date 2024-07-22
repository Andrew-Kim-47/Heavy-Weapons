extends Sprite2D

var oscillation = 30
var max_oscillation
var left = true
var position_offset = 0

func _physics_process(delta):
	position_offset = randf_range(-1, 1)
	max_oscillation = oscillation
	position += Vector2.from_angle(rotation + PI / 2) * (oscillation * position_offset)
	#if position_offset <= -1:
		#left = false
	#elif position_offset >= 1:
		#left = true
	#if left:
		#position_offset -= delta * 40
	#else:
		#position_offset += delta * 40
	
