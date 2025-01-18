extends Label


func _process(delta: float) -> void:
	self.text = "Gold: " + str(Gvar.Gold)
