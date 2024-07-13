extends Node

var cash = 6000
var total_kills = 0
var level_kills = 0
var level_cash = 0
var weapon1 = "diagonals"
var weapon2
var weapon3


func collect(amount):
	cash += amount
	
func add_kills(amount):
	total_kills += amount
