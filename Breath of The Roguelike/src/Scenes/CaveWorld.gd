extends Node

export (PackedScene) var player
export (PackedScene) var actor

var dimension = Vector2(1000,1000)
var drunk_start = Vector2(dimension.x/2,dimension.y/2)
var drunk_steps = 120000
var drunk_minor_steps = 10000
var minor_caves
var minor_cave_size
var seeds = []
var z_level = -1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	minor_caves = randi() % 8
	print("Minors: ", minor_caves)
	var portion = 0.05
	var steps = 0
	for y in range(dimension.y):
		for x in range(dimension.x):
			steps += 1
	portion = int(steps * portion)
	print(steps, " + ", portion)
	steps = 0
	for y in range(dimension.y):
		for x in range(dimension.x):
			$"32RoguesWallTiles".set_cell(x,y,0)
			$"32RoguesWallTiles".update_bitmask_area(Vector2(x,y))
			steps += 1
			if steps % portion == 0:
				yield(get_tree(),"idle_frame")
	print("Painted with base coat.")
	var start = drunk_start
	seeds.append(start)
	for step in range(drunk_steps):
		$"32RoguesWallTiles".set_cellv(start,-1)
		$"32RoguesWallTiles".update_bitmask_area(Vector2(start.x,start.y))
		var stuff = randf() * 100
		if stuff > 0 and stuff < 30:
			$"32RoguesFloorTiles".set_cellv(start,1,false,false,false,Vector2(randi()%3,0))
		elif stuff > 30 and stuff < 31:
			if start in seeds:
				pass
			else:
				seeds.append(start)
		var dir = Vector2(
			(randi() % 3) - 1,
			(randi() % 3) - 1 
		)
		start += dir
	print("Starting little caves.")
	for cave in minor_caves:
		minor_cave_size = randi() % drunk_minor_steps
		print(minor_cave_size)
		var x = clamp(randi()%int(dimension.x), int(dimension.x*0.05), int(dimension.x-(dimension.x*0.05)))
		var y = clamp(randi()%int(dimension.y), int(dimension.y*0.05), int(dimension.y-(dimension.y*0.05)))
		start = Vector2(x,y)
		print(start)
		for step in range(minor_cave_size):
			$"32RoguesWallTiles".set_cellv(start,-1)
			$"32RoguesWallTiles".update_bitmask_area(Vector2(start.x,start.y))
			var stuff = randf() * 100
			if stuff > 0 and stuff < 30:
				$"32RoguesFloorTiles".set_cellv(start,1,false,false,false,Vector2(randi()%3,0))
#			elif 30 < stuff < 31:
#				if start in seeds:
#					pass
#				else:
#					seeds.append(start)
			var dir = Vector2(
				(randi() % 3) - 1,
				(randi() % 3) - 1 
			)
			start += dir
	print("Finished Generation, let's get acting!")
	seeds.shuffle()
	print(seeds)
	var first = seeds.pop_front()
	var new_player = player.instance()
	new_player.tileData = Vector2(0,0)
	new_player.celVec3 = Vector3(first.x,first.y,z_level)
	$Actors.add_child(new_player)
	$"32RoguesActorMap".set_cellv(first,0,false,false,false,Vector2(0,0))
	for s in seeds:
#		var loc = $"32RoguesWallTiles".get_cell_autotile_coord(s.x,s.y)
		var new_actor = actor.instance()
		new_actor.tileData = Vector2(0,2)
		new_actor.celVec3 = Vector3(s.x,s.y,z_level)
		$Actors.add_child(new_actor)
		$"32RoguesActorMap".set_cellv(s,1,false,false,false,Vector2(0,2))
		pass
	print($Actors.get_children())
	print("Now play!")
	EntityGlobals.game_start = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
