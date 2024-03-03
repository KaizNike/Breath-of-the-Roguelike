extends Actor

var blocked = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var vec
	if not blocked:
		vec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if vec:
#		celVec3 += Vector3(vec.x,vec.y,0)
		pos_changed(celVec3 + Vector3(vec.x,vec.y,0))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _unhandled_input(event):
#	var vec = event.get_vector()
