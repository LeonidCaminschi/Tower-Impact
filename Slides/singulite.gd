extends Label


func _process(delta: float) -> void:
	self.text = "Singulite: " + str(Gvar.singulite)
