extends CharacterBody3D

var looking_dir = 0.0
var last_dir = Vector3.FORWARD

func _process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "forwards", "backwards").rotated($CamPivot.rotation.y)
	print(input_dir)
	if not input_dir.is_zero_approx():
		looking_dir = atan2(input_dir.x, input_dir.y)
		last_dir = Vector3(
			input_dir.x,
			0,
			input_dir.y
		)

	#$CamPivot.rotation.y = lerp_angle($CamPivot.rotation.y, looking_dir, delta * 5)
	$CamPivot.rotation.y = looking_dir

	move_and_slide()

	DebugDraw3D.draw_arrow(global_position, global_position + last_dir * 3, Color.BLACK, 0.1)
	DebugDraw3D.draw_arrow(global_position, global_position + Vector3.FORWARD, Color.RED, 0.1)
