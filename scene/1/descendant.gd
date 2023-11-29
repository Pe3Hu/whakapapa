extends MarginContainer


@onready var health = $VBox/Health

var ancestor = null
var index = null


func set_attributes(input_: Dictionary) -> void:
	ancestor  = input_.ancestor
	index = int(Global.num.index.descendant)
	Global.num.index.descendant += 1
	
	var input = {}
	input.descendant = self
	input.limits = {}
	input.limits.vigor = 0.25
	input.limits.standard = 0.5
	input.limits.fatigue = 0.25
	input.total = 100
	health.set_attributes(input)
