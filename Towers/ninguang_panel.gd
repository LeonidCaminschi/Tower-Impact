extends Panel


@onready var tower = preload("res://Towers/ninguang.tscn")
var currTile

func _on_gui_input(event: InputEvent) -> void:
	if Gvar.Gold >= 10:
		var tempTower = tower.instantiate()
		if event is InputEventMouseButton and event.button_mask == 1:
			# Left Click Down
			add_child(tempTower)
			
			tempTower.process_mode = Node.PROCESS_MODE_DISABLED
			
			tempTower.scale = Vector2(0.32,0.32)
			
		elif event is InputEventMouseMotion and event.button_mask == 1:
			# Left Click Down Drag
			if get_child_count() > 1:
				get_child(1).global_position = event.global_position
			
			var mapPath = get_tree().get_root().get_node("Game/TileMapLayer")
			var tile = mapPath.local_to_map(get_global_mouse_position())
			currTile = mapPath.get_cell_atlas_coords(tile)
			var targets = get_child(1).get_node("TowerDetector").get_overlapping_bodies()
			
			if (is_tile_valid(currTile)):
				if targets.size() > 0:
					get_child(1).get_node("Area").modulate = Color(255,255,255, 0.3)
				else:
					get_child(1).get_node("Area").modulate = Color(0,255,0, 0.3)
			else:
				get_child(1).get_node("Area").modulate = Color(255,255,255, 0.3)
			
		elif event is InputEventMouseButton and event.button_mask == 0:
			# Left Click Up
			if event.global_position.x >= 2944:
				if get_child_count() > 1:
					get_child(1).queue_free()
					
			else:
				if get_child_count() > 1:
					get_child(1).queue_free()
				if (is_tile_valid(currTile)):
					var path = get_tree().get_root().get_node("Game/Towers")
					var targets = get_child(1).get_node("TowerDetector").get_overlapping_bodies()
					if targets.size() < 1:
						path.add_child(tempTower)
						tempTower.global_position = event.global_position
						tempTower.get_node("Area").hide()
						Gvar.Gold -= 10
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()
				

func is_tile_valid(currTile: Vector2i) -> bool:
	# Define a list of valid tiles
	var valid_tiles = [
		Vector2i(10, 0), Vector2i(11, 0), Vector2i(12, 0), Vector2i(13, 0), 
		Vector2i(10, 1), Vector2i(11, 1), Vector2i(12, 1), Vector2i(13, 1), Vector2i(14, 1), 
		Vector2i(10, 2), Vector2i(11, 2), Vector2i(12, 2), Vector2i(13, 2), 
		Vector2i(10, 3), Vector2i(11, 3), Vector2i(12, 3), Vector2i(14, 3), 
		Vector2i(10, 4), Vector2i(11, 4), Vector2i(12, 4), Vector2i(13, 4), Vector2i(14, 4), 
		Vector2i(10, 5), Vector2i(11, 5), Vector2i(12, 5), Vector2i(13, 5),
		Vector2i(10, 6), Vector2i(11, 6), Vector2i(12, 6), Vector2i(13, 6), Vector2i(14, 6),
		Vector2i(10, 7), Vector2i(11, 7), Vector2i(12, 7), Vector2i(13, 7), Vector2i(14, 7), 
		Vector2i(10, 8), Vector2i(11, 8), Vector2i(12, 8), Vector2i(13, 8), 
		Vector2i(0, 9), Vector2i(1, 9), Vector2i(2, 9), Vector2i(3, 9), Vector2i(4, 9), 
		Vector2i(5, 9), Vector2i(6, 9), Vector2i(7, 9), Vector2i(8, 9), Vector2i(9, 9), 
		Vector2i(10, 9), Vector2i(11, 9), Vector2i(12, 9), Vector2i(13, 9), Vector2i(14, 9),
		Vector2i(0, 10),  Vector2i(2, 10), Vector2i(3, 10), Vector2i(4, 10), 
		Vector2i(5, 10), Vector2i(7, 10), Vector2i(8, 10), Vector2i(9, 10), 
		Vector2i(10, 10), Vector2i(12, 10), Vector2i(13, 10), Vector2i(14, 10),
		Vector2i(0, 11), Vector2i(1, 11), Vector2i(2, 11), Vector2i(3, 11), Vector2i(4, 11),
		Vector2i(5, 11), Vector2i(6, 11), Vector2i(7, 11), Vector2i(8, 11), Vector2i(9, 11), 
		Vector2i(10, 11), Vector2i(11, 11), Vector2i(12, 11),Vector2i(13, 11), Vector2i(14, 11)
		]
	# Check if the current tile is in the list of valid tiles
	return !currTile in valid_tiles
