extends MarginContainer


@onready var bg = $BG
@onready var stages = $Stages
@onready var actions = $Actions

var struggle = null
var descendant = null
var side = null


func set_attributes(input_: Dictionary) -> void:
	struggle = input_.struggle
	descendant = input_.descendant
	side = input_.side
	
	var style = StyleBoxFlat.new()
	style.bg_color = Global.color.side[side]
	bg.set("theme_override_styles/panel", style)


func add_action(frequency_: int) -> void:
	var input = {}
	input.timeline = self
	input.stages = Global.dict.stage.frequency[frequency_]
	
	var action = Global.scene.action.instantiate()
	actions.add_child(action)
	action.set_attributes(input)
