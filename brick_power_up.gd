extends CharacterBody2D

@export var SPEED: float = 50
const BRICK_PATH = preload("res://brick_projectile.tscn")

func _physics_process(delta):
	velocity = Vector2(0, SPEED * 1)

	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group('missile') and $Area2D.collision_layer == 1:
		for i in 20:
			var brick = BRICK_PATH.instantiate()
			get_parent().call_deferred("add_child", brick)
			brick.position = position
			i =-1
		queue_free()
	elif area.is_in_group('player') and $Area2D.collision_layer == 1:
		SPEED = 0
		$Bucket.queue_free()
		$Parachute.queue_free()
		$Area2D.collision_layer = 2
		$BucketDestruction.emitting = true 
		get_tree().call_group("brick", "brickReset")
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(3.1).timeout
		queue_free()
	elif area.is_in_group('border'):
		SPEED = 0
		$Parachute.hide()
