extends CharacterBody2D


@export var speed = 1000
var Health = 10

func _process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	if get_parent().get_progress_ratio() == 1:
		queue_free()
		
	if Health <= 0:
		get_parent().get_parent().queue_free()