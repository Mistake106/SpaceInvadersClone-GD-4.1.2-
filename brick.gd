extends StaticBody2D

#connected from the Area2D node of the brick
func _on_area_2d_area_entered(area):
	#if area.is_in_group('missile') or area.is_in_group('icicle'):
		#changing the collision layer and hiding the brick after it has been hit
	if !area.is_in_group('brick') and !area.is_in_group('enemy') and $Area2D.collision_layer == 1:
		if area.is_in_group('icicle') or area.is_in_group('bucket'):
			$AudioStreamPlayer2D.play()
		$Sprite2D.hide()
		$Area2D.collision_layer = 2
		$Destruction.emitting = true 
		$Destruction2.emitting = true
		await get_tree().create_timer(0.5).timeout
		$AudioStreamPlayer2D.stop()


func brickReset():
	#returning the brick to it's original state
	$Area2D.collision_layer = 1
	$Sprite2D.show()
func getHit():
	if $Area2D.collision_layer == 1:
		$Sprite2D.hide()
		$Area2D.collision_layer = 2
		$Destruction.emitting = true 
		$Destruction2.emitting = true
		await get_tree().create_timer(0.5).timeout
		$AudioStreamPlayer2D.stop()

