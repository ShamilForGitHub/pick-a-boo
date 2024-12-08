extends Node

signal gems_updated
signal level_updated

var gems_collected = 0
var upgrades = {
	"speed": 1,
	"jump": 1,
	"vision": 1,
	"attack": 0,
	"attack_range": 1,
	"charisma": 0
}
var max_upgrades = {
	"speed": 5,
	"jump": 5,
	"vision": 5,
	"attack": 5,
	"attack_range": 5,
	"charisma": 5
}
var upgrade_costs = {
	"speed": 1,
	"jump": 1,
	"vision": 1,
	"attack": 2,
	"attack_range": 1,
	"charisma": 1
}
var downgrade_refund = {
	"speed": 5,
	"jump": 5,
	"vision": 5,
	"attack": 10,
	"attack_range": 5,
	"charisma": 10
}
var last_level = ""
var current_level = 1

func _ready():
	print_debug("global ready!")
	print_debug(gems_collected)

func _input(event):
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file("res://main_menu.tscn")

func can_upgrade(stat: String) -> bool:
	return upgrades[stat] < max_upgrades[stat] and gems_collected >= get_upgrade_cost(stat)

func get_upgrade_cost(stat: String) -> int:
	return upgrade_costs[stat]

func upgrade_stat(stat: String) -> bool:
	if can_upgrade(stat):
		gems_collected -= get_upgrade_cost(stat)
		upgrades[stat] += 1
		emit_signal("gems_updated")
		return true
	return false

func can_downgrade(stat: String) -> bool:
	return upgrades[stat] > 0

func downgrade_stat(stat: String) -> bool:
	if can_downgrade(stat):
		upgrades[stat] -= 1
		gems_collected += downgrade_refund[stat]
		if upgrades[stat] < 0:
			upgrades[stat] = 0
		emit_signal("gems_updated")
		return true
	return false

func save_progress(level_path: String):
	last_level = level_path

func load_last_level() -> String:
	return last_level

func set_current_level(level_num: int):
	current_level = level_num
	emit_signal("level_updated", current_level)
