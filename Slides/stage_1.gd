extends Button


func _on_pressed() -> void:
	Gvar.selectedTowers.clear()
	get_tree().change_scene_to_file("res://Slides/PartyPrep.tscn")
