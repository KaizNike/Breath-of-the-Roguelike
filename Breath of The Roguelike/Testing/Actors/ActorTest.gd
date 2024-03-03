class_name Actor
extends Node

export var celVec3 := Vector3.ZERO setget pos_changed
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
	EntityGlobals.emit_signal("entity_moved", locVec3)
	var canMove = yield(EntityGlobals, "can_move")
	if canMove:
		celVec3 = locVec3
	else:
		print(actorDict.name, "Can't move!")
	
