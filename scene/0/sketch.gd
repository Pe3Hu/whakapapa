extends MarginContainer


@onready var cradle = $HBox/Cradle
@onready var battleground = $HBox/Battleground


func _ready() -> void:
	var input = {}
	input.sketch = self
	cradle.set_attributes(input)
	battleground.set_attributes(input)
