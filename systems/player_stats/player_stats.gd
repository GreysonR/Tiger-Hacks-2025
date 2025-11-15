extends Node

var money: int = 0
# Put upgrades here
var speed = 8.0
var turn_rate = 18.0
var health = 5
var damage = 1
var fire_rate = 1500

var health_upgrade_costs = [6, 20, 50, 100, 200]
var health_amts = [10, 15, 30, 50, 100]
var health_i = 0
func upgrade_health():
	if money < health_upgrade_costs[health_i]:
		return
	health = health_amts[health_i]
	money -= health_upgrade_costs[health_i]
	health_i += 1
	save()


var damage_upgrade_costs = [5, 20, 50, 100, 200]
var damage_amts = [2, 4, 8, 12, 18]
var damage_i = 0
func upgrade_damage():
	if money < damage_upgrade_costs[damage_i]:
		return
	money -= damage_upgrade_costs[damage_i]
	damage = damage_amts[damage_i]
	damage_i += 1
	save()
	
var fire_rate_upgrade_costs = [5, 15, 30, 80, 160]
var fire_rate_amts = [1200, 1000, 700, 500, 300]
var fire_rate_i = 0
func upgrade_fire_rate():
	if money < fire_rate_upgrade_costs[fire_rate_i]:
		return
	money -= fire_rate_upgrade_costs[fire_rate_i]
	fire_rate = fire_rate_amts[fire_rate_i]
	fire_rate_i += 1
	save()

	
var man_upgrade_costs = [10, 40, 100]
var man_amts_speed = [9, 11, 15]
var man_amts_turn = [18, 19, 20]
var man_i = 0
func upgrade_man():
	if money < man_upgrade_costs[man_i]:
		return
	money -= man_upgrade_costs[man_i]
	turn_rate = man_amts_turn[man_i]
	speed = man_amts_speed[man_i]
	man_i += 1
	save()


# Saving & Loading
const save_filename = "user://save_game"
func save():
	var save_file = FileAccess.open(save_filename, FileAccess.WRITE)
	var save_data = {
		"money": money,
		"health": health_i,
		"damage": damage_i,
		"fire_rate": fire_rate_i,
		"maneuverability": man_i,
	}
	var save_json = JSON.stringify(save_data)
	save_file.store_line(save_json)

## Loads the game from the save file. Returns if it loaded successfully (user has a save) or not (fresh game)
func load() -> bool:
	if !FileAccess.file_exists(save_filename):
		return false
		
	var save_file = FileAccess.open(save_filename, FileAccess.READ)
	var json_string = save_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		return false
	
	var data = json.data
	money = int(data.money)
	health_i = int(data.health)
	damage_i = int(data.damage)
	fire_rate_i = int(data.fire_rate)
	man_i = int(data.maneuverability)
	
	if health_i > 0:
		health = health_amts[health_i - 1]
	if damage_i > 0:
		damage = damage_amts[damage_i - 1]
	if fire_rate_i > 0:
		fire_rate = fire_rate_amts[fire_rate_i - 1]
	if man_i > 0:
		turn_rate = man_amts_turn[man_i - 1]
		speed = man_amts_speed[man_i - 1]
	
	return true
