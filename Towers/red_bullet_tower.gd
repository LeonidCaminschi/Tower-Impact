extends StaticBody2D

var Bullet = preload("res://Towers/red_bullet.tscn")
var bulletDamage = 5
var pathName
var currTargets = []
var curr

var reload = 0
var range = 400

@onready var timer = get_node("Upgrade/ProgressBar/Timer")
var startShooting = false


func _process(delta):
	get_node("Upgrade/ProgressBar").global_position = self.position + Vector2(-64, -81)
	if is_instance_valid(curr):
		if self.global_position.x < curr.global_position.x:
			self.get_child(2).flip_h = false
		else:
			self.get_child(2).flip_h = true
		if timer.is_stopped():
			Shoot()
			timer.start()
	else:
		for i in get_node("BulletContainer").get_child_count():
			get_node("BulletContainer").get_child(i).queue_free()
	update_powers()
	
func Shoot():
	var tempBullet = Bullet.instantiate()
	tempBullet.pathName = pathName
	tempBullet.bulletDamage = bulletDamage
	get_node("BulletContainer").add_child(tempBullet)
	tempBullet.global_position = $Aim.global_position

func _on_tower_body_entered(body):
	if "Soldier A" in body.name:
		var tempArray = []
		currTargets = get_node("Tower").get_overlapping_bodies()
		
		for i in currTargets:
			if "Soldier" in i.name:
				tempArray.append(i)
				
		var currTarget = null
		
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
		
		curr = currTarget
		pathName = currTarget.get_parent().name
		

func _on_tower_body_exited(body: Node2D) -> void:
	currTargets = get_node("Tower").get_overlapping_bodies()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node("Game/Towers")
		for i in towerPath.get_child_count():
			if towerPath.get_child(i).name != self.name:
				towerPath.get_child(i).get_node("Upgrade/Upgrade").hide()
		get_node("Upgrade/Upgrade").visible = !get_node("Upgrade/Upgrade").visible
		get_node("Upgrade/Upgrade").global_position = self.position + Vector2(-572,81)
		


func _on_timer_timeout():
	Shoot()


func _on_range_pressed():
	range += 30


func _on_attack_speed_pressed():
	if reload <= 2:
		reload += 0.1
	timer.wait_time = 3 - reload


func _on_power_pressed():
	bulletDamage += 1

func update_powers():
	get_node("Upgrade/Upgrade/HBoxContainer/Range/Label").text = str(range)
	get_node("Upgrade/Upgrade/HBoxContainer/AttackSpeed/Label").text = str(3 - reload)
	get_node("Upgrade/Upgrade/HBoxContainer/Power/Label").text = str(bulletDamage)
	
	get_node("Tower/CollisionShape2D").shape.radius = range

func _on_range_mouse_entered():
	get_node("Tower/CollisionShape2D").show()


func _on_range_mouse_exited():
	get_node("Tower/CollisionShape2D").hide()
