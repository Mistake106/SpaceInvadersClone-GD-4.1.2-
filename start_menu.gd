extends Node

func _ready():
	await get_tree().create_timer(1.0).timeout
	$AudioStreamPlayer2D.play()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
