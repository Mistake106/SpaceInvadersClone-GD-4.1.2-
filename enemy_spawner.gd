extends CharacterBody2D

const SPEED = 300.0
var isPaused: bool = false

const ENEMY_PATH = preload("res://my_enemy.tscn")
var moveDirection: int = -1

func _ready():
	$Timer.start(1)

func _process(delta):
	if isPaused == false:
		velocity = Vector2(moveDirection * SPEED, 0)
		if global_position.x <= 0.00:
			moveDirection = 1
		elif global_position.x >= 1150.00:
			moveDirection = -1
		move_and_slide()


func _on_timer_timeout():
	if isPaused == false:
		var enemy = ENEMY_PATH.instantiate()
		get_parent().add_child(enemy)
		enemy.position = Vector2(position.x, -5)
		$Timer.wait_time = RandomNumberGenerator.new().randf_range(1.00, 3.00)



