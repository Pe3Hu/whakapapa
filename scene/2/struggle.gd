extends MarginContainer


@onready var descendants = $VBox/Descendants
@onready var left = $VBox/Timelines/Left
@onready var right = $VBox/Timelines/Right

var battleground = null
var winner = null


func set_attributes(input_: Dictionary) -> void:
	battleground  = input_.battleground
	
	for descendant in input_.descendants:
		add_descendant(descendant)
	
	
	for side in Global.arr.side:
		var timeline = get(side)
		timeline.descendant.choose_action()
	
	
	left.descendant.target = right.descendant
	right.descendant.target = left.descendant
	
	#skip_shortest_ticks()


func add_descendant(descendant_: MarginContainer) -> void:
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

 
func get_shortest_stage() -> MarginContainer:
	var datas = []
	
	for side in Global.arr.side:
		var timeline = get(side)
		
		if timeline.stages.get_child_count() > 0:
			var data = {}
			data.stage = timeline.stages.get_child(0)
			data.duration = data.stage.get_upcoming_ticks()
			datas.append(data)
	
	datas.sort_custom(func(a, b): return a.duration < b.duration)
	return datas.front().stage


func skip_shortest_ticks() -> void:
	var stage = get_shortest_stage()
	print(stage.get_upcoming_ticks())
	
	for side in Global.arr.side:
		var timeline = get(side)
		timeline.ticks.next = stage.get_upcoming_ticks()
		timeline.tween_ticks()
