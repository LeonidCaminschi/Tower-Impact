extends Node2D

@onready var path = preload("res://Stages/Stage1.tscn")
@onready var path2 = preload("res://Stages/Stage1A.tscn")
@onready var path3 = preload("res://Stages/Stage1B.tscn")

func _ready() -> void:
	var timer = $Timer
	timer.wait_time = 1

func _on_timer_timeout() -> void:
	var tempPath = path.instantiate()
	add_child(tempPath)
	tempPath = path2.instantiate()
	add_child(tempPath)
	tempPath = path3.instantiate()
	add_child(tempPath)
