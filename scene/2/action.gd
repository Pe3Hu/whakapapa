extends MarginContainer


var timeline = null


func set_attributes(input_: Dictionary) -> void:
	timeline  = input_.timeline
	
	for type in input_.stages:
		var input = {}
		input.action = self
		input.duration = input_.stages[type]
		input.type = type
		
		var stage = Global.scene.stage.instantiate()
		timeline.stages.add_child(stage)
		stage.set_attributes(input)
