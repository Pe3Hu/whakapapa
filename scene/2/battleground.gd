extends MarginContainer


@onready var struggles = $Struggles

var sketch = null


func set_attributes(input_: Dictionary) -> void:
	sketch  = input_.sketch
	
	init_struggles()


func init_struggles() -> void:
	for _i in 1:
		var input = {}
		input.battleground = self
		input.descendants = []
		
		for _j in 2:
			var descendant = sketch.cradle.ancestors.get_child(_j).descendants.get_child(0)
			input.descendants.append(descendant)
		
		var struggle = Global.scene.struggle.instantiate()
		struggles.add_child(struggle)
		struggle.set_attributes(input)
