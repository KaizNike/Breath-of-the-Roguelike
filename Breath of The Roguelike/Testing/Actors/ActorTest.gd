class_name Actor
extends Node

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
	id = EntityGlobals.set_entity_id()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func pos_changed(locVec3):
	if not EntityGlobals.game_start:
		celVec3 = locVec3
		return
	EntityGlobals.emit_signal("entity_move_check",celVec3 ,locVec3, id)
	
	

func move(canMove, destVec3, idCheck):
	if id != idCheck:
		return
	if canMove:
		EntityGlobals.emit_signal("entity_moved",celVec3 ,destVec3, tileData, id)
		celVec3 = destVec3
	else:
		print(actorDict.name, "Can't move!")
	pass
