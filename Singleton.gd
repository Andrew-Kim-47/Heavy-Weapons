extends Node

var cash = 0
var total_kills = 0
var level_kills = 0
var level_cash = 0


func collect(amount):
	cash += amount
	
func add_kills(amount):
	total_kills += amount
