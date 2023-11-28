extends MarginContainer


@onready var descendants = $Descendants

var cradle = null


func set_attributes(input_: Dictionary) -> void:
	cradle  = input_.cradle
	
	init_descendants()


func init_descendants() -> void:
	for _i in 1:
		var input = {}
		input.ancestor = self
	
		var descendant = Global.scene.descendant.instantiate()
		descendants.add_child(descendant)
		descendant.set_attributes(input)
