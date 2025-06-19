extends CharacterBody3D

func _process(delta: float) -> void:
	var input_dir = Input.get_vector("right", "left", "forwards", "backwards")
	print(input_dir)

	var target_velocity = Vector3.ZERO

	if not input_dir.is_zero_approx():
		var camera_basis = $CamPivot.global_transform.basis

		var cam_forward = -camera_basis.z.normalized()
		var cam_right = camera_basis.x.normalized()

		cam_forward.y = 0
		cam_right.y = 0

		cam_forward = cam_forward.normalized()
		cam_right = cam_right.normalized()


		var desired_movement_direction = (cam_forward * input_dir.y + cam_right * input_dir.x).normalized()
		target_velocity = desired_movement_direction * 5
		print(target_velocity)
		if not target_velocity.is_zero_approx():
			var target_angle = atan2(desired_movement_direction.x, desired_movement_direction.z)
			rotation.y = lerp_angle(rotation.y, target_angle, delta * 1)

	velocity.x = target_velocity.x
	velocity.z = target_velocity.z

	# velocity.y -= gravity * delta

	move_and_slide()

	DebugDraw3D.draw_arrow(global_position, global_position + velocity, Color.BLACK, 0.1)

	# print(rotation.y)
