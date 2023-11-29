extends MarginContainer


@onready var health = $VBox/Health

var ancestor = null
var index = null
var target = null
var timeline = null


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


func choose_action() -> void:
	if timeline.struggle.winner == null:
		Global.rng.randomize()
		var action = 6 - index * 5#Global.rng.randi_range(1, 6)
		timeline.add_action(action)


func apply_effect() -> void:
	Global.rng.randomize()
	var damage = Global.rng.randi_range(6, 14)
