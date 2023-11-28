extends MarginContainer


@onready var descendants = $VBox/Descendants
@onready var left = $VBox/Timelines/Left
@onready var right = $VBox/Timelines/Right

var battleground = null


func set_attributes(input_: Dictionary) -> void:
	battleground  = input_.battleground
	
	for descendant in input_.descendants:
		add_descendant(descendant)
	
	left.add_action(1)
	right.add_action(4)


func add_descendant(descendant_: MarginContainer) -> void:
	var parent = descendant_.get_parent()
	var b = descendant_.ancestor.descendants
	descendant_.ancestor.descendants.remove_child(descendant_)
	descendants.add_child(descendant_)
	
	var input = {}
	input.struggle = self
	input.descendant = descendant_
	
	if left.descendant == null:
		input.side = "left"
	else:
		input.side = "right"
	
	var timeline = get(input.side)
	timeline.set_attributes(input)
