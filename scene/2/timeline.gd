extends MarginContainer


@onready var bg = $HBox/BG
@onready var stages = $HBox/BG/Stages
@onready var actions = $Actions
@onready var marker = $HBox/Marker
@onready var timer = $Timer

var struggle = null
var descendant = null
var side = null
var ticks = {}
var tween = null
var pace = null
var time = null
var anchor = null


func set_attributes(input_: Dictionary) -> void:
	struggle = input_.struggle
	descendant = input_.descendant
	side = input_.side
	
	ticks.current = 0
	ticks.max = 120
	pace = 1
	time = Time.get_unix_time_from_system()
	anchor = Vector2(0, 0)
	
	var input = {}
	input.proprietor = self
	input.type = "ancestor"
	input.subtype = str(descendant.ancestor.index)
	input.value = descendant.index
	marker.set_attributes(input)
	
	var style = StyleBoxFlat.new()
	style.bg_color = Global.color.side[side]
	bg.set("theme_override_styles/panel", style)
	
	#custom_minimum_size = Global.vec.size.tick
	#custom_minimum_size.x *= ticks.max
	update_bg_size()


func add_action(frequency_: int) -> void:
	var input = {}
	input.timeline = self
	input.stages = Global.dict.stage.frequency[frequency_]
	
	var action = Global.scene.action.instantiate()
	actions.add_child(action)
	action.set_attributes(input)


func update_bg_size() -> void:
	bg.custom_minimum_size = Global.vec.size.tick
	bg.custom_minimum_size.x *= ticks.max


func _on_timer_timeout():
	if pace >= 0.5:
		var stage = stages.get_child(0)
		ticks.current = stage.get_upcoming_ticks()
		var gap = Vector2(Global.vec.size.tick.x, 0)
		gap.x *= -ticks.current
		var time = 1.0 / pace
		tween = create_tween()
		tween.tween_property(stages, "position", gap, time).from(Vector2(0, 0))
		tween.tween_callback(add_elapsed_ticks)
		#decelerate_spin()
	else:
		#print("end at", Time.get_unix_time_from_system() - time)
		#pool.dice_stopped(self)
		#var unit = stages.get_child(3).unit
		pass


func add_elapsed_ticks() -> void:
	var stage = stages.get_child(0)
	stage.add_elapsed_ticks(ticks.current)
