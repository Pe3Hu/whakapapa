extends MarginContainer


@onready var vigor = $HBox/Indicators/Vigor
@onready var standard = $HBox/Indicators/Standard
@onready var fatigue = $HBox/Indicators/Fatigue
@onready var marker = $HBox/Marker
@onready var indicators = $HBox/Indicators

var descendant = null
var value = {}
var limits = {}
var state = null
var effort = null
var overstrain = null


func set_attributes(input_: Dictionary) -> void:
	descendant = input_.descendant
	limits = input_.limits
	
	value.total = int(input_.total)
	value.current = int(input_.total)
	init_states()
	
	var input = {}
	input.proprietor = self
	input.type = "ancestor"
	input.subtype = str(descendant.ancestor.index)
	input.value = descendant.index
	marker.set_attributes(input)


func init_states() -> void:
	for _state in Global.arr.state:
		var indicator = get(_state)
		
		var input = {}
		input.health = self
		input.state = _state
		input.max = limits[_state] * value.total
		indicator.set_attributes(input)
	
	update_state()
	make_an_effort(0)


func update_state() -> void:
	for _state in Global.arr.state:
		var indicator = get(_state)
		
		if indicator.get_percentage() > 0:
			state = _state
			break


func make_an_effort(effort_: int) -> void:
	var indicator = get(state) 
	indicator.update_value("current", -effort_)
	update_state()


func exert_effort() -> void:
	var chances = Global.dict.temperament.title[descendant.temperament].chances[state]
	effort = Global.get_random_key(chances)
	#make_an_effort(Global.dict.effort[effort])

