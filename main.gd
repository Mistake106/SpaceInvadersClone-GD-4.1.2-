extends Node

var musicToggle:int = 1

func _ready():
	$Music.play()
	$EnemySpawner2.isPaused = true
	$EnemySpawner3.isPaused = true
	get_tree().call_group("brick", "brickReset")

func _process(_delta):
	$AmmoCount.text = str($Player.ammo)
	$KillCount.text = str(Global.flufflesKilled)
	
	if Global.flufflesKilled >= 100:
		$EnemySpawner2.isPaused = false
	else:
		$EnemySpawner2.isPaused = true
	
	if Global.flufflesKilled >= 250:
		$EnemySpawner3.isPaused = false
	else:
		$EnemySpawner3.isPaused = true
	
	if Input.is_action_just_pressed("pause"):
		_on_pause_button_pressed()
	if musicToggle == -1:
		$Music.stop()

func _on_game_over_menu_restart():
	newGame()

func newGame():
	Global.flufflesKilled = 0
	get_tree().call_group("enemy", "queue_free")
	get_tree().call_group('icicle', 'queue_free')
	get_tree().call_group('bucket', 'queue_free')
	get_tree().call_group("brick", "brickReset")
	get_tree().call_group("iceStorm", "newGame")
	$PowerUpSpawner.newGame()
	$Music.play()
	$GameOverMenu/UnpauseButton.show()
	$PauseButton.show()
	get_tree().paused = false
	$GameOverMenu.hide()
	get_tree().call_group("player", "fullAmmo")




func _on_pause_button_pressed():
	$PauseButton.hide()
	get_tree().paused = true
	$GameOverMenu.show()
	
func _on_game_over_menu_unpause():
		get_tree().paused = false
		$GameOverMenu.hide()
		$PauseButton.show()

func _on_mute_music_pressed():
	musicToggle *= -1
	if musicToggle == 1:
		$Music.play()


func _on_game_over_menu_hide_pause():
	$PauseButton.hide()

