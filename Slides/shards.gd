extends Label


func _process(delta: float) -> void:
	self.text = "Shards: " + str(Gvar.singularity_shard)
