extends Node

var money: int = 0
# Put upgrades here
var speed = 8.0
var turn_rate = 18.0
var health = 1
var damage = 1
var fire_rate = 1500

var health_upgrade_costs = [6, 20, 40]
var health_amts = [10, 15, 25]
var health_i = 0
func upgrade_health():
	if money < health_upgrade_costs[health_i]:
		return
	health = health_amts[health_i]
	health_i += 1
	money -= health_upgrade_costs[fire_rate_i]


var damage_upgrade_costs = [5, 20, 40]
var damage_amts = [2, 4, 8]
var damage_i = 0
func upgrade_damage():
	if money < damage_upgrade_costs[damage_i]:
		return
	damage = damage_amts[damage_i]
	damage_i += 1
	money -= damage_upgrade_costs[fire_rate_i]
	
var fire_rate_upgrade_costs = [5, 15, 30]
var fire_rate_amts = [1200, 1000, 700]
var fire_rate_i = 0
func upgrade_fire_rate():
	if money < fire_rate_upgrade_costs[fire_rate_i]:
		return
	fire_rate = fire_rate_amts[fire_rate_i]
	fire_rate_i += 1
	money -= fire_rate_upgrade_costs[fire_rate_i]

	
var man_upgrade_costs = [5, 15, 20]
var man_amts_speed = [10, 13, 15]
var man_amts_turn = [19, 19, 19]
var man_i = 0
func upgrade_man():
	if money < man_upgrade_costs[man_i]:
		return
	turn_rate = man_amts_turn[man_i]
	speed = man_amts_speed[man_i]
	man_i += 1
	money -= man_upgrade_costs[fire_rate_i]
