extends CharacterBody2D

var attackRng = RandomNumberGenerator.new().randi_range(1, 7)
var rng = RandomNumberGenerator.new().randf_range(1.00, -1.00)
const MISSILE_PATH = preload("res://icicle.tscn")

var canCollideWithBrick = true
var FALL_SPEED = 30
var SPEED = 100
var moveDirection:int 

func _ready():
	$Timer.wait_time = attackRng
	if rng >= 0:
		moveDirection = 1
	elif rng <= 0:
		moveDirection = -1
	else:
		moveDirection = -1

func _physics_process(delta):
	velocity = Vector2(moveDirection * SPEED, FALL_SPEED * 1)
	
	if global_position.x <= 0.00:
		moveDirection = 1
	elif global_position.x >= 1150.00:
		moveDirection = -1
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group('brick') and canCollideWithBrick == true:
		canCollideWithBrick = false
		FALL_SPEED = -FALL_SPEED 
		while FALL_SPEED < 0:
			FALL_SPEED += 1
			await get_tree().create_timer(0.1).timeout
		await get_tree().create_timer(0.5).timeout
		FALL_SPEED = 30
		canCollideWithBrick = true
		
	
	if area.is_in_group('missile') or area.is_in_group('brickMoving') or area.is_in_group('border'):
		Global.flufflesKilled += 1
		SPEED = 0
		FALL_SPEED = 0
		$Timer.queue_free()
		$AnimatedSprite2D.queue_free()
		$Area2D.queue_free()
		$"fluffle destruction".emitting = true
		$fluffleSnowDestruction.emitting = true
		await get_tree().create_timer(10.0).timeout
		queue_free()

func die():
	if SPEED != 0:
		Global.flufflesKilled += 1
		SPEED = 0
		FALL_SPEED = 0
		$Timer.queue_free()
		$AnimatedSprite2D.queue_free()
		$Area2D.queue_free()
		$"fluffle destruction".emitting = true
		$fluffleSnowDestruction.emitting = true
		await get_tree().create_timer(10.0).timeout
		queue_free()

func _on_timer_timeout():
	if $"fluffle destruction".emitting == false:
		var icicle = MISSILE_PATH.instantiate()
		get_parent().add_child(icicle)
		icicle.position = position
		$Timer.wait_time = attackRng
