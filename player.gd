extends CharacterBody3D

var looking_dir = 0.0
var last_dir = Vector3.FORWARD
var acceleration_factor = 0.1

func _process(delta: float) -> void:
	var input_2d = Input.get_vector("left", "right", "forwards", "backwards")
	var input_dir = Vector3(input_2d.x, 0, input_2d.y).rotated(Vector3.UP, $CamPivot.rotation.y)
	print("input_dir: ", input_dir)

	if not input_dir.is_zero_approx():
		looking_dir = atan2(-input_dir.x, -input_dir.z)
		last_dir = Vector3(
			input_dir.x,
			0,
			input_dir.z
		)
		velocity = lerp(velocity, last_dir * 5, delta * 30)
	else:
		velocity = lerp(velocity, Vector3.ZERO, delta * 10)

	$CamPivot.rotation.y = lerp_angle($CamPivot.rotation.y, looking_dir, delta * 3)
	#$CamPivot.rotation.y = looking_dir
	print(velocity)
	move_and_slide()

	DebugDraw3D.draw_arrow(global_position, global_position + last_dir * 3, Color.BLACK, 0.1)
	DebugDraw3D.draw_arrow(global_position, global_position + Vector3.FORWARD, Color.RED, 0.1)
