extends CharacterBody2D

@export var SPEED: float = 300

func _physics_process(delta):
	velocity = Vector2(0, SPEED * 1)

	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group('brick') or area.is_in_group('missile'):
		queue_free()
	if (area.is_in_group('player') or area.is_in_group('bucket')) and $Area2D.collision_layer == 1:
		SPEED = 0
		$IcicleDestruction.emitting = true
		$Sprite2D.hide()
		$Area2D.collision_layer = 10
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.5).timeout
		queue_free()
	elif area.is_in_group('border'):
		await get_tree().create_timer(RandomNumberGenerator.new().randf_range(0.05, 0.08)).timeout
		SPEED = 0
		get_parent().remove_from_group('icicle')
		if is_instance_valid(self) == true:
			get_node("Area2D").remove_from_group('icicle')
	
		
		
