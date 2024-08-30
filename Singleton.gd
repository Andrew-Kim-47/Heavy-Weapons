extends Node

var current_level
var cash = 0
var total_kills = 0
var level_kills = 0
var level_cash = 0
var weapon1 = "shot"
var weapon2 = "ricochet"
var weapon3 = "slow_time"


func collect(amount):
	cash += amount
	
func add_kills(amount):
	total_kills += amount
