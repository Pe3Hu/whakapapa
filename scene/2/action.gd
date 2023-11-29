extends MarginContainer


var timeline = null
var frequency = null


func set_attributes(input_: Dictionary) -> void:
	timeline  = input_.timeline
	frequency  = input_.frequency
	
	for type in Global.dict.stage.frequency[frequency]:
		var input = {}
		input.action = self
		input.duration = Global.dict.stage.frequency[frequency][type]
		input.type = type
		
		var stage = Global.scene.stage.instantiate()
		timeline.stages.add_child(stage)
		stage.set_attributes(input)


func apply_effect() -> void:
	Global.rng.randomize()
	var damage = Global.rng.randi_range(6, 14)
