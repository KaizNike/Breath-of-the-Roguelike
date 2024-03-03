class_name Actor
extends Node2D

var blocked = false

export var celVec3 := Vector3.ZERO setget pos_changed
var tileData = Vector2(1000,1000)
var tileID = 0
var moveAllows = 0
var canRiseFall = false
export (int) var id
export var actorDict := {
	"name": "???",
	"ai": ""
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	EntityGlobals.connect("can_move",self,"actor_interact")
	EntityGlobals.connect("can_move",self,"move")
	EntityGlobals.connect("second_can_move",self,"move")
	EntityGlobals.connect("return_world_pos",self,"update_pos_from_map")
	Globals.connect("tick_request",self,"tick")
	id = EntityGlobals.set_entity_id()
	pos_changed(celVec3)
	pass # Replace with function body.


func tick():
	if actorDict.ai == "random":
		if not blocked:
			var dir = Vector2(
				(randi() % 3) - 1,
				(randi() % 3) - 1 
			)
			dir = Vector2(dir.x+celVec3.x,dir.y+celVec3.y)
#			if canRiseFall:
#				dir = Vector3(dir.x,dir.y,(randi() % 3) - 1)
			pos_changed(Vector3(dir.x,dir.y,0))
		pass

func pos_changed(locVec3):
	if not EntityGlobals.game_start:
		celVec3 = locVec3
		EntityGlobals.emit_signal("get_world_pos", Vector2(celVec3.x,celVec3.y), id)
		return
	EntityGlobals.emit_signal("entity_move_check",celVec3 ,locVec3, id)
	
func actor_interact(canMove,destVec3,worldPos,idCheck):
	if id != idCheck:
		return
	if canMove:
		pass
#		EntityGlobals.emit_signal("entity_moved",celVec3 ,destVec3, tileData, id)
#		var oldVec3 = celVec3
#		celVec3 = destVec3
##		position = (Vector2(celVec3.x,celVec3.y) * Globals.cellSize) + Vector2(8,8)
#		position = worldPos
#		print("@: Origin:",oldVec3," Dest:",destVec3," Pos:", position)
	else:
		print("Let's talk!")

func move(canMove, destVec3, worldPos, idCheck):
	if id != idCheck:
		return
	if canMove:
		moveAllows += 1
	else:
		moveAllows = 0
	if canMove and moveAllows == 2:
		EntityGlobals.emit_signal("entity_moved",celVec3 ,destVec3, tileData, tileID, id)
		var oldVec3 = celVec3
		celVec3 = destVec3
#		position = (Vector2(celVec3.x,celVec3.y) * Globals.cellSize) + Vector2(8,8)
		position = worldPos + Vector2(16,16)
		print("@: Origin:",oldVec3," Dest:",destVec3," Pos:", position)
		moveAllows = 0
	else:
		print(actorDict.name, "Can't move!")
	pass


func update_pos_from_map(pos, checkId):
	if id == checkId:
		position = pos + Vector2(16,16)
		print("Pos change: ", position)
