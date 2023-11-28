extends MarginContainer


@onready var ancestors = $Ancestors

var sketch = null


func set_attributes(input_: Dictionary) -> void:
	sketch = input_.sketch
	
	init_ancestors()


func init_ancestors() -> void:
	for _i in 2:
		var input = {}
		input.cradle = self
	
		var ancestor = Global.scene.ancestor.instantiate()
		ancestors.add_child(ancestor)
		ancestor.set_attributes(input)
