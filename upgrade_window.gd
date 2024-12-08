extends Window

func _ready() -> void:
	size = Vector2(400, 400)
	update_ui()
	var stats = ["speed", "jump", "vision", "attack", "range"]  # Изменение
	for stat in stats:  # Изменение
		var upgrade_btn = $VBoxContainer.get_node(stat.capitalize() + "HBox/Upgrade" + stat.capitalize() + "Button")  # Изменение
		upgrade_btn.connect("pressed", Callable(self, "_on_upgrade_stat_pressed").bind(stat))  # Изменение
	$VBoxContainer/CloseButton.connect("pressed", Callable(self, "_on_close_pressed"))

func update_ui() -> void:
	var g = Global
	$VBoxContainer/SpeedHBox/SpeedLevel.text = str(g.upgrades["speed"])
	$VBoxContainer/JumpHBox/JumpLevel.text = str(g.upgrades["jump"])
	$VBoxContainer/VisionHBox/VisionLevel.text = str(g.upgrades["vision"])
	$VBoxContainer/AttackHBox/AttackLevel.text = str(g.upgrades["attack"])
	$VBoxContainer/RangeHBox/RangeLevel.text = str(g.upgrades["attack_range"])
	$VBoxContainer/GemsLabel.text = "Гемы: " + str(g.gems_collected)

	update_upgrade_buttons("speed", $VBoxContainer/SpeedHBox/UpgradeSpeedButton)
	update_upgrade_buttons("jump", $VBoxContainer/JumpHBox/UpgradeJumpButton)
	update_upgrade_buttons("vision", $VBoxContainer/VisionHBox/UpgradeVisionButton)
	update_upgrade_buttons("attack", $VBoxContainer/AttackHBox/UpgradeAttackButton)
	update_upgrade_buttons("attack_range", $VBoxContainer/RangeHBox/UpgradeRangeButton)

func update_upgrade_buttons(stat: String, button: Button) -> void:
	var g = Global
	if g.upgrades[stat] < g.max_upgrades[stat] and g.gems_collected >= g.get_upgrade_cost(stat):
		button.disabled = false
		button.text = "Улучшить " + stat.capitalize() + " (" + str(g.get_upgrade_cost(stat)) + " гемов)"
	else:
		if g.upgrades[stat] >= g.max_upgrades[stat]:
			button.text = "Максимум"
		else:
			button.text = "Недостаточно гемов"
		button.disabled = true

func _on_upgrade_stat_pressed(stat: String) -> void:
	var g = Global
	if g.upgrade_stat(stat):
		var player = get_tree().current_scene.get_node("Player")
		if player:
			player.update_stats()
			if stat == "charisma":
				player.unlock_charisma_features()
			elif stat == "vision":  # Изменение
				player.update_camera_vision()  # Изменение
	update_ui()

func _on_close_pressed() -> void:
	hide()
