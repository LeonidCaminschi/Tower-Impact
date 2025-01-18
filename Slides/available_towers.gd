extends HBoxContainer

var selectedTowers = {}

# This function will be called when the button is pressed
func _on_button_pressed(button: Button, tower: String):
	# Change the background color of the button (panel)
	if(!button.get_theme_stylebox("normal").bg_color == Color(1,1,1)):
		var style = StyleBoxFlat.new()
		style.bg_color = Color(1,1,1)
		button.add_theme_stylebox_override("normal", style)
		if(selectedTowers.keys().size() < 4):
			selectedTowers[tower] = null
	else:
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.6,0.6,0.6)
		button.add_theme_stylebox_override("normal", style)
		selectedTowers.erase(tower)
	
	print(selectedTowers)

func _ready() -> void:
	for maiden_path in Gvar.maidens:
		# Create a button (instead of a Panel) to make it interactive
		var button = Button.new()
		button.set_custom_minimum_size(Vector2(600, 600))  # Set size for the button

		# Load the image as a texture
		var texture = load(maiden_path)
		if texture == null:
			print("Failed to load texture: ", maiden_path)
			continue  # Skip this iteration if the image doesn't load

		# Create a TextureRect to display the image inside the button
		var texture_rect = TextureRect.new()
		texture_rect.texture = texture
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.set_custom_minimum_size(Vector2(500, 500))  # Size of each rectangle

		# Add the TextureRect to the button (acting as the background)
		button.add_child(texture_rect)

		# Connect the button's 'pressed' signal to change background color
		button.button_down.connect(_on_button_pressed.bind(button, maiden_path))

		# Add the button to the parent container
		self.add_child(button)

		# Optional: Set initial position for the button
		#button.position = Vector2(150, 150)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
