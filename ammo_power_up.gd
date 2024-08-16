extends CharacterBody2D


@export var SPEED: float = 50

func _physics_process(delta):
	velocity = Vector2(0, SPEED * 1)

	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group('missile') and !area.is_in_group('player') and !$Area2D.collision_layer == 2:
		SPEED = 0
		$AmmoBox.queue_free()
		$Parachute.queue_free()
		$Explosion.emitting = true
		$Area2D.collision_layer = 2
		get_tree().call_group("brick", "getHit")
		get_tree().call_group("enemy", "die")
		get_tree().call_group("icicle", "queue_free")
		get_tree().call_group("brickMoving", "queue_free")
		$ExplosionSF.play()
		await get_tree().create_timer(1.9).timeout
		queue_free()
	elif area.is_in_group('player') and !$Area2D.collision_layer == 2:
		SPEED = 0
		$Area2D.collision_layer = 2
		$Parachute.queue_free()
		$AmmoBox.queue_free()
		get_tree().call_group("player", "fullAmmo")
		$PickUpSF.play()
		await get_tree().create_timer(2.0).timeout
		queue_free()
	elif area.is_in_group('border'):
		SPEED = 0
		$Parachute.hide()
