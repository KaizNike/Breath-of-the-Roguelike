class_name Actor
extends Node

export var celVec3 := Vector3.ZERO setget pos_changed
var tileData = Vector2(1000,1000)
export var actorDict := {
	"name": "???"
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func pos_changed(locVec3):
	if not EntityGlobals.game_start:
		celVec3 = locVec3
		return
	EntityGlobals.emit_signal("entity_moved",celVec3 ,locVec3, tileData)
	var canMove = yield(EntityGlobals, "can_move")
	if canMove:
		celVec3 = locVec3
	else:
		print(actorDict.name, "Can't move!")
	
