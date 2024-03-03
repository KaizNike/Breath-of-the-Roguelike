class_name Actor
extends Node2D

export var celVec3 := Vector3.ZERO setget pos_changed
var tileData = Vector2(1000,1000)
export (int) var id
export var actorDict := {
	"name": "???"
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EntityGlobals.connect("can_move",self,"move")
	EntityGlobals.connect("return_world_pos",self,"update_pos_from_map")
	id = EntityGlobals.set_entity_id()
	pos_changed(celVec3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func pos_changed(locVec3):
	if not EntityGlobals.game_start:
		celVec3 = locVec3
		EntityGlobals.emit_signal("get_world_pos", Vector2(celVec3.x,celVec3.y), id)
		return
	EntityGlobals.emit_signal("entity_move_check",celVec3 ,locVec3, id)
	
	

func move(canMove, destVec3, worldPos, idCheck):
	if id != idCheck:
		return
	if canMove:
		EntityGlobals.emit_signal("entity_moved",celVec3 ,destVec3, tileData, id)
		var oldVec3 = celVec3
		celVec3 = destVec3
#		position = (Vector2(celVec3.x,celVec3.y) * Globals.cellSize) + Vector2(8,8)
		position = worldPos
		print("@: Origin:",oldVec3," Dest:",destVec3," Pos:", position)
	else:
		print(actorDict.name, "Can't move!")
	pass


func update_pos_from_map(pos, checkId):
	if id == checkId:
		position = pos
