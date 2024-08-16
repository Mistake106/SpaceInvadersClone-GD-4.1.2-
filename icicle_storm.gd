extends Node

const ICICLE_PATH = preload("res://icicle.tscn")
var start: bool = false
var isActive: bool = false
var icicleCounter: int = 0

@export var timerTimeLeft: int = 25
func _ready():
	$Timer.wait_time = timerTimeLeft
func _process(delta):
	$Label.text = str($Timer.time_left) + "\n" + str($Timer.wait_time)
	if Global.flufflesKilled >= 50 and start == false:
		$Timer.start(1)
		start = true
	if Global.flufflesKilled < 50:
		isActive = false


func spawnIcicles():
	while isActive == true and icicleCounter < 100:
		var icicle = ICICLE_PATH.instantiate()
		icicleCounter += 1
		get_parent().add_child(icicle)
		icicle.position = Vector2i(RandomNumberGenerator.new().randi_range(5, 1195), 0)
		await get_tree().create_timer(0.1).timeout
		if icicleCounter == 100:
			stop()
		
func stop():
	isActive = false
	icicleCounter = 0
	if Global.flufflesKilled >= 75 and Global.flufflesKilled <= 150:
		$Timer.start(timerTimeLeft)
	elif Global.flufflesKilled >= 151 and Global.flufflesKilled <= 250:
		$Timer.start(timerTimeLeft - 10)
	elif Global.flufflesKilled >= 251 and Global.flufflesKilled <= 400:
		$Timer.start(timerTimeLeft - 15)
	elif Global.flufflesKilled >= 401:
		$Timer.start(timerTimeLeft - 17)
	$AudioStreamPlayer2D.stop()

func newGame():
	$Timer.stop()
	$Timer.wait_time = timerTimeLeft
	start = false
	isActive = false
	icicleCounter = 0
	$AudioStreamPlayer2D.stop()

func _on_area_2d_area_entered(area):
	if area.is_in_group('icicle'):
		if Global.flufflesKilled >= 75 and Global.flufflesKilled <= 150:
			$Timer.start(timerTimeLeft)
		elif Global.flufflesKilled >= 151 and Global.flufflesKilled <= 250:
			$Timer.start(timerTimeLeft - 10)
		elif Global.flufflesKilled >= 251 and Global.flufflesKilled <= 400:
			$Timer.start(timerTimeLeft - 15)
		elif Global.flufflesKilled >= 401:
			$Timer.start(timerTimeLeft - 17)

func _on_timer_timeout():
	$Timer.stop()
	isActive = true
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(2.0).timeout
	
	spawnIcicles()
