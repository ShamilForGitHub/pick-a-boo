extends CanvasLayer

var UpgradeWindowScene = preload("res://upgrade_window.tscn")
var upgrade_window_instance = null

func _ready():
	$UpgradeButton.connect("pressed", Callable(self, "_on_UpgradeButton_pressed"))
	Global.connect("gems_updated", Callable(self, "_on_gems_updated"))
	Global.connect("level_updated", Callable(self, "_on_level_updated"))
	update_hud()

func _on_UpgradeButton_pressed():
	if not upgrade_window_instance:
		upgrade_window_instance = UpgradeWindowScene.instantiate()
		add_child(upgrade_window_instance)
	else:
		upgrade_window_instance.queue_free()
		upgrade_window_instance = UpgradeWindowScene.instantiate()
		add_child(upgrade_window_instance)
	upgrade_window_instance.show()

func _on_gems_updated():
	if Global.gems_collected != null:
		$GemsLabel.text = "Гемы: " + str(Global.gems_collected)

func _on_level_updated(level_num):
	if level_num != null:
		$CurrentLevel.text = "Уровень: " + str(level_num)

func update_hud():
	$GemsLabel.text = "Гемы: " + str(Global.gems_collected)
	$CurrentLevel.text = "Уровень: " + str(Global.current_level)

func set_level(level_num):  # Новый метод
	$CurrentLevel.text = "Уровень: " + str(level_num)

func set_gems(gems_count):  # Новый метод
	$GemsLabel.text = "Гемы: " + str(gems_count)
