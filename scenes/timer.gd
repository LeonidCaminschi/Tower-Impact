extends Label

@onready var timer = get_node("../Timer")

func _process(delta: float) -> void:
	self.text = str(int(timer.time_left))
	if (int(timer.time_left) == 0):
		self.hide()
