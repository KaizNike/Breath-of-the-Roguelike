extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var z_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	EntityGlobals.connect("entity_moved",self,"move_entity")
	EntityGlobals.connect("entity_move_check",self,"check_collision")
	EntityGlobals.connect("get_world_pos",self,"return_world_pos")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func check_collision(celVec3, destVec3, id):
	var world_pos = map_to_world(Vector2(destVec3.x,destVec3.y))
	if get_cell(destVec3.x,destVec3.y) == -1:
		EntityGlobals.emit_signal("can_move", true,destVec3,world_pos,id)
	else:
		EntityGlobals.emit_signal("can_move",false,destVec3,world_pos,id)
	
	
func move_entity(celVec3, destVec3, tileData, tileID, id):
	set_cell(celVec3.x,celVec3.y,-1)
	set_cell(destVec3.x,destVec3.y,tileID,false,false,false,tileData)


func return_world_pos(loc, id):
	EntityGlobals.emit_signal("return_world_pos", map_to_world(loc), id)
