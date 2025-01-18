extends Button

# Declare rewards as colors for rectangles
var rewards = [
	Color(1, 0, 0),  # Red
	Color(0, 1, 0),  # Green
	Color(0, 0, 1),  # Blue
	Color(1, 1, 0),  # Yellow
	Color(1, 0, 1),  # Magenta
	Color(0, 1, 1)   # Cyan
]

# Reference to the container where rectangles will be displayed
@onready var reward_container = $"../RewardContainer"

func clear_children():
	for child in reward_container.get_children():
		child.queue_free()

# Function to handle pulling rewards
func pull_rewards(count: int):
	# Clear previous rewards
	clear_children()
	
	if(Gvar.singularity_shard < count):
		return
		
	Gvar.singularity_shard -= count;

	# Pull the rewards
	for i in range(count):
		var percent = randi() % 1000
		if (percent > 0 && percent < 300): Gvar.upgrade_material += 10
		if (percent > 300 && percent < 500): Gvar.upgrade_material += 15
		if (percent > 500 && percent < 750): Gvar.upgrade_material += 20
		if (percent > 750 && percent < 900): Gvar.upgrade_material += 25
		if (percent > 900 && percent < 999): Gvar.upgrade_material += 30
		if (percent == 1000): 
			if (!Gvar.maidens.has("res://assets/towers/Asset-5.png")):
				Gvar.maidens.append("res://assets/towers/Asset-5.png")
			else: 
				Gvar.singularity_shard += 100
		
		# Randomly select a reward
		var random_index = randi() % rewards.size()
		var random_color = rewards[random_index]

		# Create a new rectangle for the reward
		var reward_rect = ColorRect.new()
		reward_rect.color = random_color
		reward_rect.set_custom_minimum_size(Vector2(100, 100))  # Size of each rectangle

		# Add the rectangle to the reward container
		reward_container.add_child(reward_rect)


func _on_pressed() -> void:
	pull_rewards(10)
