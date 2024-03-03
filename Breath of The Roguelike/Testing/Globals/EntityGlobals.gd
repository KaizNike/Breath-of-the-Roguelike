extends Node

signal entity_moved(posVec3, destVec3, tileData, tileID, id)
signal entity_move_check(posVec3, destVec3, id)
signal can_move(Bool, destVec3,worldPos, id)
signal second_can_move(Bool, destVec3, worldPos, id)

signal get_world_pos(loc, id)
signal return_world_pos(pos, id)

signal change_chat_visibilty(Bool)

signal turn_complete
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var activeIds = []
var playerId

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
