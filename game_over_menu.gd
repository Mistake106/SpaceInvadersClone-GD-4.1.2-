extends CanvasLayer



signal restart
signal unpause
signal hidePause

func _process(delta):
	$KillCount.text = str(Global.flufflesKilled)

func _on_restart_button_pressed():
	hide()
	restart.emit()


func _on_player_show_menu():
	show()
	$UnpauseButton.hide()
	hidePause.emit()


func _on_unpause_button_pressed():
	unpause.emit()
