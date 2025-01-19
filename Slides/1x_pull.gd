extends Button

# ----------------------------------------------------------------------------------
# ICONS / COLORS
# ----------------------------------------------------------------------------------
const ICON_UPGRADE_MATERIAL = preload("res://assets/TD Tiles/towerDefense_tile022.png")
const ICON_CHARACTER = preload("res://assets/towers/Asset-5.png")

const COLOR_MATERIAL = Color("87cefa")   # Light Blue
const COLOR_CHARACTER = Color("ffd700")  # Gold

# ----------------------------------------------------------------------------------
# SCENE REFERENCES
# ----------------------------------------------------------------------------------
@onready var reward_container = $"../RewardContainer"

# ----------------------------------------------------------------------------------
# UTILITY FUNCTIONS
# ----------------------------------------------------------------------------------
func clear_children():
	for child in reward_container.get_children():
		child.queue_free()

# ----------------------------------------------------------------------------------
# MAIN LOGIC: X1 PULL
# ----------------------------------------------------------------------------------
func pull_single_reward():
	# Clear the reward display area
	clear_children()

	# Check if we have enough shards for a single pull
	if Gvar.singularity_shard < 1:
		return

	# Deduct cost for x1 pull
	Gvar.singularity_shard -= 1

	# Only one reward
	var percent = randi() % 10000
	var reward_text = ""
	var reward_icon: Texture = null
	var background_color: Color = COLOR_MATERIAL

	# -------------------------
	# REWARD GENERATION LOGIC
	# -------------------------
	if percent > 0 and percent < 300:
		Gvar.upgrade_material += 10
		reward_text = "x10"
		reward_icon = ICON_UPGRADE_MATERIAL
	elif percent >= 300 and percent < 500:
		Gvar.upgrade_material += 15
		reward_text = "x15"
		reward_icon = ICON_UPGRADE_MATERIAL
	elif percent >= 500 and percent < 750:
		Gvar.upgrade_material += 20
		reward_text = "x20"
		reward_icon = ICON_UPGRADE_MATERIAL
	elif percent >= 750 and percent < 900:
		Gvar.upgrade_material += 25
		reward_text = "x25"
		reward_icon = ICON_UPGRADE_MATERIAL
	elif percent >= 900 and percent < 999:
		Gvar.upgrade_material += 30
		reward_text = "x30"
		reward_icon = ICON_UPGRADE_MATERIAL
	elif percent <= 10000:
		if not Gvar.maidens.has("res://assets/towers/Asset-5.png"):
			Gvar.maidens.append("res://assets/towers/Asset-5.png")
			reward_text = "New"
			reward_icon = ICON_CHARACTER
			background_color = COLOR_CHARACTER
		else:
			Gvar.singularity_shard += 100
			reward_text = "x100"
			reward_icon = ICON_UPGRADE_MATERIAL

	# -------------------------
	# UI CREATION / LAYOUT
	# -------------------------

	# 1) Background square
	var background_rect = ColorRect.new()
	background_rect.color = background_color
	background_rect.set_custom_minimum_size(Vector2(100, 100))
	background_rect.add_theme_constant_override("margin_top", 10)
	background_rect.add_theme_constant_override("margin_bottom", 10)
	background_rect.add_theme_constant_override("margin_left", 10)
	background_rect.add_theme_constant_override("margin_right", 10)

	# 2) CenterContainer ensures everything inside is centered overall
	var center_container = CenterContainer.new()
	center_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	center_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	background_rect.add_child(center_container)

	# 3) VBoxContainer stacks two rows: (icon row) + (label)
	var reward_panel = VBoxContainer.new()
	reward_panel.alignment = BoxContainer.ALIGNMENT_CENTER
	reward_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	reward_panel.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	center_container.add_child(reward_panel)

	# --(A) HBox for icon row--
	var icon_row = HBoxContainer.new()
	icon_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	icon_row.alignment = BoxContainer.ALIGNMENT_CENTER

	# Spacer to push icon to the right
	var left_spacer = Control.new()
	left_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	icon_row.add_child(left_spacer)

	# 4) The icon
	var reward_icon_rect = TextureRect.new()
	reward_icon_rect.texture = reward_icon
	reward_icon_rect.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	reward_icon_rect.set_custom_minimum_size(Vector2(80, 80))
	reward_icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	reward_icon_rect.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	reward_icon_rect.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	icon_row.add_child(reward_icon_rect)

	# (Optional) Another spacer if you need a gap on the right side
	# var right_spacer = Control.new()
	# right_spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	# icon_row.add_child(right_spacer)

	# Add icon row to the vbox
	reward_panel.add_child(icon_row)

	# --(B) Label row--
	var reward_label = Label.new()
	reward_label.text = reward_text
	reward_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	reward_label.add_theme_font_size_override("font_size", 14)
	reward_panel.add_child(reward_label)

	# 5) Add the entire background to the main RewardContainer
	reward_container.add_child(background_rect)

# ----------------------------------------------------------------------------------
# BUTTON SIGNAL
# ----------------------------------------------------------------------------------
func _on_pressed() -> void:
	pull_single_reward()
