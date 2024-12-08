extends Node2D

func _ready():
	$Options/StartButton.connect("pressed", Callable(self, "_on_start_button_pressed"))
	$Options/ContinueButton.connect("pressed", Callable(self, "_on_continue_button_pressed"))
	$Options/FullscreenButton.connect("pressed", Callable(self, "_on_fullscreen_button_pressed"))
	$Options/QuitButton.connect("pressed", Callable(self, "_on_quit_button_pressed"))
	$Options/StartButton.grab_focus()
	
	if Global.load_last_level() == "":
		$Options/ContinueButton.disabled = true
	else:
		$Options/ContinueButton.disabled = false
	
	if !OS.has_feature("pc"):
		$Options/FullscreenButton.hide()
		$Options/QuitButton.hide()

func _on_start_button_pressed():
	Global.save_progress("res://level_1.tscn")
	get_tree().change_scene_to_file("res://level_1.tscn")

func _on_continue_button_pressed():
	var lvl = Global.load_last_level()
	if lvl != "":
		get_tree().change_scene_to_file(lvl)

func _on_fullscreen_button_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_quit_button_pressed():
	get_tree().quit()
