extends CharacterBody2D

@export var ACCELERATION:float = 400

const MISSILE_PATH = preload("res://missile.tscn")

var ammo: int = 200

signal showMenu

var move_direction: float

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_left") and global_position.x >= 0:
		move_direction = -1
		velocity = Vector2(move_direction * ACCELERATION, 0)
		$AnimatedSprite2D.animation = 'moving'
		$AnimatedLights.animation = 'Moving'
	elif Input.is_action_pressed("move_right") and global_position.x <= 1160:
		move_direction = 1
		velocity = Vector2(move_direction * ACCELERATION, 0)
		$AnimatedSprite2D.animation = 'moving'
		$AnimatedLights.animation = 'Moving'
	else:
		velocity = Vector2.ZERO 
		$AnimatedSprite2D.animation = 'default'
		$AnimatedLights.animation = 'Standing'
		
	if Input.is_action_just_pressed("shoot_missile") and ammo > 0:
		var missile = MISSILE_PATH.instantiate()
		get_parent().add_child(missile)
		missile.position = $Marker2D.global_position
		$AudioStreamPlayer2D.play()
		ammo -= 1
	
	if Global.flufflesKilled >= 300:
		$AnimatedLights.show()
	if Global.flufflesKilled >= 400:
		$LaserPointer.show()
	
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group('enemy') or area.is_in_group('icicle'):
		showMenu.emit()
		get_tree().paused = true
		
func fullAmmo():
	ammo = 200
