extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var cells = get_used_cells()
	var num = 0
	for cell in cells:
		var id = get_cell_autotile_coord(cell.x,cell.y)
		print(id, " @ ", cell, " Num: ", num)
		num += 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
