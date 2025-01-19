extends Node

# Temporary currency
var Gold = 100
var Health = 10

# Persistant currency
var upgrade_material = 100
var singulite = 500
var singularity_shard = 10

# Units
var maidens = ["res://assets/towers/Asset-1.png", "res://assets/towers/Asset-2.png", "res://assets/towers/Asset-3.png", "res://assets/towers/Asset-4.png"]

var selectedTowers = {}


func towerMapper(tower:String):
	if(tower == "res://assets/towers/Asset-1.png"):
		return "res://Towers/red_bullet_tower.tscn"
	if(tower == "res://assets/towers/Asset-2.png"):
		return "res://Towers/ninguang.tscn"
	if(tower == "res://assets/towers/Asset-3.png"):
		return "res://Towers/shenhe.tscn"
	if(tower == "res://assets/towers/Asset-4.png"):
		return "res://Towers/miko.tscn"
	if(tower == "res://assets/towers/Asset-5.png"):
		return "res://Towers/kazuha.tscn"
