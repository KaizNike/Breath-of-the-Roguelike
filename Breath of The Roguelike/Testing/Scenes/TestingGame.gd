extends Node

onready var actorMap = $"32RoguesActorMap"
onready var actorsNode = $Actors

export (PackedScene) var player
export (PackedScene) var actor
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var cells = actorMap.get_used_cells()
	var num = 0
	for cell in cells:
		var id = actorMap.get_cell_autotile_coord(cell.x,cell.y)
		if id == Vector2(1,4):
			var new = player.instance()
			new.tileData = id
			new.celVec3 = Vector3(cell.x,cell.y,actorMap.z_level)
			actorsNode.add_child(new)
		else:
			var new = actor.instance()
			new.tileData = id
			new.celVec3 = Vector3(cell.x,cell.y,actorMap.z_level)
			actorsNode.add_child(new)
		print(id, " @ ", cell, " Num: ", num)
		num += 1
	print(actorsNode.get_children())
	pass # Replace with function body.
	EntityGlobals.game_start = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
