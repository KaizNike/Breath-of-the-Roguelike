extends TileMap

var z_level = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EntityGlobals.connect("entity_move_check",self,"check_collision")
	pass # Replace with function body.


func check_collision(celVec3, destVec3, id):
	var world_pos = map_to_world(Vector2(destVec3.x,destVec3.y))
	if get_cell(destVec3.x,destVec3.y) == -1:
		EntityGlobals.emit_signal("second_can_move", true,destVec3,world_pos,id)
	else:
		EntityGlobals.emit_signal("second_can_move",false,destVec3,world_pos,id)
