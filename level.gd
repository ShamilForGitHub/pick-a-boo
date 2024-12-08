extends Node2D

@export var level_num = 0

func _ready():
	if $HUD and $HUD.has_method("set_level"):
		$HUD.set_level(level_num)
	set_gems_label()
	for gem in $Gems.get_children():
		gem.gem_collected.connect(_on_gem_collected)
	var player = get_tree().current_scene.get_node("Player")
	if player:
		player.update_stats()

func _on_gem_collected():
	set_gems_label()

func set_gems_label():
	if $HUD and $HUD.has_method("set_gems"):
		$HUD.set_gems(Global.gems_collected)

func _on_door_player_entered(level_path: String):
	Global.save_progress(level_path)
	get_tree().change_scene_to_file(level_path)

func _input(event):
	if event.is_action_pressed("reset_level"):
		get_tree().reload_current_scene.call_deferred()
		Global.gems_collected = 0
		set_gems_label()
