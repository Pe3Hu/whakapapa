extends MarginContainer


@onready var bar = $ProgressBar

var action = null
var type = null


func set_attributes(input_: Dictionary) -> void:
	action  = input_.action
	type  = input_.type
	
	bar.max_value = input_.duration
	bar.value = bar.max_value
	custom_minimum_size = Vector2(Global.vec.size.bar)
	custom_minimum_size.x *= bar.max_value
	set_colors()


func set_colors() -> void:
	var keys = ["fill", "background"]
	
	for key in keys:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Global.color.stage[type][key]
		var path = "theme_override_styles/" + key
		bar.set(path, style_box)