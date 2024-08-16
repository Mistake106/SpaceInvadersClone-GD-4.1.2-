extends RigidBody2D
var epicX = RandomNumberGenerator.new().randf_range(-900.00, 900.00)
var epicY = RandomNumberGenerator.new().randf_range(-500.00, -1200.00)
func _ready():
	apply_impulse(Vector2(epicX, epicY))
	apply_torque_impulse(RandomNumberGenerator.new().randf_range(-300.00, 300.00))
func _process(delta):
	$Destruction.gravity = linear_velocity
	$Destruction2.gravity = linear_velocity

func _on_area_2d_area_entered(area):
	if !area.is_in_group('player') and !area.is_in_group('brickMoving') and !area.is_in_group('bucket') and !area.is_in_group('iceStorm'):
		linear_velocity = Vector2(0, 0)
		angular_velocity = 0
		gravity_scale = 0
		if !area.is_in_group('missile'):
			$AudioStreamPlayer2D.play()
		$Sprite2D.hide()
		$Area2D.collision_layer = 19
		$Destruction.emitting = true 
		$Destruction2.emitting = true
		await get_tree().create_timer(1.0).timeout
		$AudioStreamPlayer2D.stop()
		queue_free()
