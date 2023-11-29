extends MarginContainer


@onready var descendants = $Descendants

var cradle = null
var index = null


func set_attributes(input_: Dictionary) -> void:
	cradle  = input_.cradle
	index = int(Global.num.index.ancestor)
	Global.num.index.ancestor += 1
	
	init_descendants()


func init_descendants() -> void:
	for _i in 1:
		var input = {}
		input.ancestor = self
	
		var descendant = Global.scene.descendant.instantiate()
		descendants.add_child(descendant)
		descendant.set_attributes(input)
