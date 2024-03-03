extends Node

signal entity_moved(posVec3, destVec3, tileData, id)
signal entity_move_check(posVec3, destVec3, id)
signal can_move(Bool, destVec3, id)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var activeIds = []

var game_start = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_entity_id() -> int:
	var rand = randi()
	while rand in activeIds:
		rand = randi()
	print("Tagged", rand)
	return rand
