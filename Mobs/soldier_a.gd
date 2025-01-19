extends CharacterBody2D


@export var speed = 1000
var Health = 10

func _process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	
	if get_parent().get_progress_ratio() == 1:
		Gvar.Health -= 1
		death()
		
	if Gvar.Health <= 0:
			show_game_over_popup()
		
	if Health <= 0:
		Gvar.Gold += 1
		death()
		
func death():
	get_parent().get_parent().queue_free()
	
func show_game_over_popup():
	get_tree().paused = true
	var popup = get_tree().root.get_node("Game/GameOverPopup")
	popup.popup_centered()
