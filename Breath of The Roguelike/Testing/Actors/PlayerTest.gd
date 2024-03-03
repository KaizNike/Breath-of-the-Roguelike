extends Actor


var movement_action_held = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EntityGlobals.playerId = id
	pass # Replace with function body.

func _physics_process(delta):
	if movement_action_held and not blocked:
		handle_movement()
	pass

func _unhandled_input(event):
	if (event.get_action_strength("move_rise") or event.get_action_strength("move_fall") or
	event.get_action_strength("corner_move_backleft") or event.get_action_strength("corner_move_backright") or
	event.get_action_strength("corner_move_forwardleft") or event.get_action_strength("corner_move_forwardright") or
	event.get_action_strength("move_backward") or event.get_action_strength("move_forward") or
	event.get_action_strength("move_left") or event.get_action_strength("move_right")):
		if event.is_pressed() and not movement_action_held:
			handle_movement()
			$MoveActionHeldTimer.start()
#			movement_action_held = true
	if (event.is_action_released("move_rise") or event.is_action_released("move_fall") or
	event.is_action_released("corner_move_backleft") or event.is_action_released("corner_move_backright") or
	event.is_action_released("corner_move_forwardleft") or event.is_action_released("corner_move_forwardright") or
	event.is_action_released("move_backward") or event.is_action_released("move_forward") or
	event.is_action_released("move_left") or event.is_action_released("move_right")):
		if event.is_released():
			movement_action_held = false
			$MoveActionHeldTimer.stop()
	
func handle_movement():
	var vec = Vector2.ZERO
	if not blocked:
#			vec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		vec = _get_dir().floor()
	if vec:
#		celVec3 += Vector3(vec.x,vec.y,0)
		pos_changed(celVec3 + Vector3(vec.x,vec.y,0))
		Globals.emit_signal("tick_request")


func _get_dir() -> Vector3:
	var dir = Vector3.ZERO
	var vec2 = Vector2.ZERO
	vec2 = (Input.get_action_strength("corner_move_backleft") * Vector2(-1,1) +
	Input.get_action_strength("corner_move_backright") * Vector2(1,1) +
	Input.get_action_strength("corner_move_forwardleft") * Vector2(-1,-1) +
	Input.get_action_strength("corner_move_forwardright") * Vector2(1,-1)
	)
	if not vec2:
		vec2 = Input.get_vector("move_left","move_right","move_forward","move_backward")
	var rise = Input.get_action_strength("move_rise") - Input.get_action_strength("move_fall")
	dir = Vector3(vec2.x,vec2.y,rise)
	return dir


func _on_MoveActionHeldTimer_timeout():
	print("You begin walking.")
	movement_action_held = true
	pass # Replace with function body.
	
	
