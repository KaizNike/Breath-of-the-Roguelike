extends TileMap

export (PackedScene) var player
export (PackedScene) var actor
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EntityGlobals.connect("entity_moved",self,"check_collision")
	var cells = get_used_cells()
	var num = 0
	for cell in cells:
		var id = get_cell_autotile_coord(cell.x,cell.y)
		if id == Vector2(1,4):
			var new = player.instance()
			new.tileData = id
			get_parent().get_node("Actors").add_child(new)
		else:
			var new = actor.instance()
			new.tileData = id
			get_parent().get_node("Actors").add_child(new)
		print(id, " @ ", cell, " Num: ", num)
		num += 1
	print(get_parent().get_node("Actors").get_children())
	pass # Replace with function body.
	EntityGlobals.game_start = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func check_collision(celVec3, destVec3, tileID):
	set_cell(celVec3.x,celVec3.y,-1)
	set_cell(destVec3.x,destVec3.y,0,false,false,false,tileID)
	EntityGlobals.emit_signal("can_move", true)
	
