extends CharacterBody2D

@export var SPEED: float = 500

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, SPEED * -1) 

	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group('border'):
		queue_free()
	if !area.is_in_group('missile') and !area.is_in_group('border') and !area.is_in_group('iceStorm'):
		SPEED = 0
		$Sprite2D.queue_free()
		$Trail.queue_free()
		$Area2D.queue_free()
		$Explosion.emitting = true
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.5).timeout
		queue_free()
		
	
	
