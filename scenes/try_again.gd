extends Button


func _on_pressed() -> void:
	get_tree().paused = false
	Gvar.Health = 10
	Gvar.Gold = 100
	get_tree().reload_current_scene()
	
