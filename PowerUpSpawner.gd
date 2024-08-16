extends Node

const BUCKET_PATH = preload('res://brick_power_up.tscn')
const AMMO_PATH = preload("res://ammo_power_up.tscn")

func _ready():
	newGame()
	
func _process(delta):
	$PowerUpTimerDisplay.text = str(int($AmmoTimer.time_left)) + "     " +  str(int($BucketTimer.time_left)) 

func _on_bucket_timer_timeout():
	var bucket = BUCKET_PATH.instantiate()
	get_parent().add_child(bucket)
	bucket.position = Vector2i(RandomNumberGenerator.new().randi_range(25, 1140), 0)
	if Global.flufflesKilled < 250:
		$BucketTimer.wait_time = RandomNumberGenerator.new().randi_range(160, 200)
	else:
		$BucketTimer.wait_time = RandomNumberGenerator.new().randi_range(50, 70)


func _on_ammo_timer_timeout():
	var ammo = AMMO_PATH.instantiate()
	get_parent().add_child(ammo)
	ammo.position = Vector2i(RandomNumberGenerator.new().randi_range(25, 1140), 0)
	if Global.flufflesKilled < 250:
		$AmmoTimer.wait_time = 100
	else:
		$AmmoTimer.wait_time = 50

func newGame():
	$BucketTimer.start(150)
	$AmmoTimer.start(100)
