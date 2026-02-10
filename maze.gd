extends Node2D

const N = 1
const E = 2
const S = 4
const W = 8

@export var maze_width: int = 5
@export var maze_height: int = 5
@export var Map: Node

var topLt: bool = false
var topLs: bool = false
var topRt: bool = false
var topRs: bool = false
var bottomLb: bool = false
var bottomLs: bool = false
var bottomRb: bool = false
var bottomRs: bool = false

var sides = {
	Vector2(1,0): E,
	Vector2(-1,0): W,
	Vector2(0,1): S,
	Vector2(0,-1): N, 
	}
var next_ID_pos = {
	"0": Vector2i(0,0),
	"1": Vector2i(1,0),
	"2": Vector2i(2,0),
	"3": Vector2i(3,0),
	"4": Vector2i(0,1),
	"5": Vector2i(1,1),
	"6": Vector2i(2,1), 
	"7": Vector2i(3,1),
	"8": Vector2i(0,2),
	"9": Vector2i(1,2), 
	"10": Vector2i(2,2),
	"11": Vector2i(3,2),
	"12": Vector2i(0,3),
	"13": Vector2i(1,3),
	"14": Vector2i(2,3),
	"15": Vector2i(3,3)
	}
var current_ID_pos = {
	"0": Vector2i(0,0),
	"1": Vector2i(1,0),
	"2": Vector2i(2,0),
	"3": Vector2i(3,0),
	"4": Vector2i(0,1),
	"5": Vector2i(1,1),
	"6": Vector2i(2,1), 
	"7": Vector2i(3,1),
	"8": Vector2i(0,2),
	"9": Vector2i(1,2), 
	"10": Vector2i(2,2),
	"11": Vector2i(3,2),
	"12": Vector2i(0,3),
	"13": Vector2i(1,3),
	"14": Vector2i(2,3),
	"15": Vector2i(3,3)
	}

func _ready():
	randomize()
	_generate_maze()

func _check_sides(current, unvisited):
	var list = []
	for side_check in sides.keys():
		if current + side_check in unvisited:
			list.append(current + side_check)
	return list

func _generate_maze():
	var unvisited = []
	var stack = []
	Map.clear()
	for x in maze_width:
		for y in maze_height:
			Map.set_cell(Vector2i(x,y), 15, Vector2i(3,3), 0)
			unvisited.append(Vector2(x,y))
	var current = Vector2(0,0)
	var current_ID = (15)
	unvisited.erase(current)
	while unvisited:
		var next_ID = (15)
		var neighbors = _check_sides(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			var dir = next - current
			#print("dir = " + str(dir))
			var current_walls = Map.get_cell_source_id(Vector2i(current)) - sides[dir]
			#print("current_walls = " + str(current_walls))
			#print("sides[dir] = " + str(sides[dir]))
			var next_walls = Map.get_cell_source_id(Vector2i(next)) - sides[-dir]
			#print("next_walls = " + str(next_walls))
			#print("sides[dir] = " + str(sides[-dir]))
			Map.set_cell(current, current_walls, current_ID_pos[str(current_walls)])
			#print(str(current_ID_pos[str(current_ID)]))
			#print(str(Map.set_cell(Vector2i(0,0), 0, current_ID_pos[str(current_ID)])))
			Map.set_cell(next, next_walls, next_ID_pos[str(next_walls)])
			current = next
			current_ID = next_walls
			unvisited.erase(current)
		elif stack:
			current = stack.pop_back()
		if unvisited == []:
			#print("done")
			gen_done()

func gen_done():
	for x1 in 3:
		for y1 in 3:
			Map.erase_cell(Vector2i(maze_width/2 + x1 - 1, maze_width/2 + y1 -1))

	for y in 5:
		for x in 5:
			if x > 0 and x < 4 and y < 4 and y > 0:
				pass
			elif x == 0 and y == 0:
				pass
			elif x == 0 and y == 4:
				pass
			elif x == 4 and y == 0:
				pass
			elif x == 4 and y == 4:
				pass
			else:
				#print(("(" + str(x - 2) + ", " + str(y - 2) + " ) ID: " + str(Map.get_cell_source_id(Vector2i(maze_width/2 + x - 2, maze_width/2 + y - 2)))))
				check_blanks(Map.get_cell_source_id(Vector2i(maze_width/2 + x - 2, maze_width/2 + y - 2)), x - 2, y - 2 )
	fill_blanks()

func check_blanks(ID, x, y):
	
	#center
	Map.set_cell(Vector2i(maze_width/2, maze_width/2), 0, current_ID_pos["0"])
	#middles
	
	if x == 0 and y == -2:
		if ID == 0 or ID == 1 or ID == 2 or ID == 3 or ID == 8 or ID == 9 or ID == 10 or ID == 11:
			Map.set_cell(Vector2i(maze_width/2 + x, maze_width/2 + y + 1), 0, current_ID_pos["0"])
		else:
			Map.set_cell(Vector2i(maze_width/2 + x, maze_width/2 + y + 1), 1, current_ID_pos["1"])
	elif x == 0 and y == 2:
		if ID == 0 or ID == 2 or ID == 4 or ID == 6 or ID == 8 or ID == 10 or ID == 12 or ID == 14:
			Map.set_cell(Vector2i(maze_width/2 + x, maze_width/2 + y - 1), 0, current_ID_pos["0"])
		else:
			Map.set_cell(Vector2i(maze_width/2 + x, maze_width/2 + y - 1), 4, current_ID_pos["4"])
	elif x == 2 and y == 0:
		if ID == 0 or ID == 1 or ID == 2 or ID == 3 or ID == 4 or ID == 5 or ID == 6 or ID == 7:
			Map.set_cell(Vector2i(maze_width/2 + x - 1, maze_width/2 + y), 0, current_ID_pos["0"])
		else:
			Map.set_cell(Vector2i(maze_width/2 + x - 1, maze_width/2 + y), 2, current_ID_pos["2"])
	elif x == -2 and y == 0:
		if ID == 0 or ID == 1 or ID == 4 or ID == 5 or ID == 8 or ID == 9 or ID == 12 or ID == 13:
			Map.set_cell(Vector2i(maze_width/2 + x + 1, maze_width/2 + y), 0, current_ID_pos["0"])
		else:
			Map.set_cell(Vector2i(maze_width/2 + x + 1, maze_width/2 + y), 8, current_ID_pos["8"])
		
##corners
	elif x == -1 and y == -2:
		if ID == 0 or ID == 1 or ID == 2 or ID == 3 or ID == 8 or ID == 9 or ID == 10 or ID == 11:
			topLt = true
		else:
			topLt = false
	elif x == 1 and y == -2:
		if ID == 0 or ID == 1 or ID == 2 or ID == 3 or ID == 8 or ID == 9 or ID == 10 or ID == 11:
			topRt = true
		else:
			topRt = false
	elif x == -1 and y == 2:
		if ID == 0 or ID == 2 or ID == 4 or ID == 6 or ID == 8 or ID == 10 or ID == 12 or ID == 14:
			bottomLb = true
		else:
			bottomLb = false
	elif x == 1 and y == 2:
		if ID == 0 or ID == 2 or ID == 4 or ID == 6 or ID == 8 or ID == 10 or ID == 12 or ID == 14:
			bottomRb = true
		else:
			bottomRb = false
	elif x == -2 and y == -1:
		if ID == 0 or ID == 1 or ID == 4 or ID == 5 or ID == 8 or ID == 9 or ID == 12 or ID == 13:
			topLs = true
		else:
			topLs = false
	elif x == -2 and y == 1:
		if ID == 0 or ID == 1 or ID == 4 or ID == 5 or ID == 8 or ID == 9 or ID == 12 or ID == 13:
			bottomLs = true
		else:
			bottomLs = false
	elif x == 2 and y == 1:
		if ID == 0 or ID == 1 or ID == 2 or ID == 3 or ID == 4 or ID == 5 or ID == 6 or ID == 7:
			bottomRs = true
		else:
			bottomRs = false
	elif x == 2 and y == -1:
		if ID == 0 or ID == 1 or ID == 2 or ID == 3 or ID == 4 or ID == 5 or ID == 6 or ID == 7:
			topRs = true
		else: 
			topRs = false

func fill_blanks():
		if topLs == true:
			if topLt == true:
				Map.set_cell(Vector2i(maze_width/2 - 1, maze_width/2 - 1), 0, current_ID_pos["0"])
			else:
				Map.set_cell(Vector2i(maze_width/2 - 1, maze_width/2 - 1), 1, current_ID_pos["1"])
		else:
			if topLt == true:
				Map.set_cell(Vector2i(maze_width/2 - 1, maze_height/2 - 1), 8, current_ID_pos["8"])
			else:
				Map.set_cell(Vector2i(maze_width/2 - 1, maze_height/2 - 1), 9, current_ID_pos["9"])
		if bottomLs == true:
			if bottomLb == true:
				Map.set_cell(Vector2i(maze_width/2 - 1, maze_height/2 + 1), 0, current_ID_pos["0"])
			else:
				Map.set_cell(Vector2i(maze_width/2 - 1, maze_height/2 + 1), 4, current_ID_pos["4"])
		else:
			if bottomLb == true:
				Map.set_cell(Vector2i(maze_width/2 - 1, maze_height/2 + 1), 8, current_ID_pos["8"])
			else:
				Map.set_cell(Vector2i(maze_width/2 - 1, maze_height/2 + 1), 12, current_ID_pos["12"])
		if bottomRs == true:
			if bottomRb == true:
				Map.set_cell(Vector2i(maze_width/2 + 1, maze_height/2 + 1), 0, current_ID_pos["0"])
			else:
				Map.set_cell(Vector2i(maze_width/2 + 1, maze_height/2 + 1), 4, current_ID_pos["4"])
		else:
			if bottomRb == true:
				Map.set_cell(Vector2i(maze_width/2 + 1, maze_height/2 + 1), 2, current_ID_pos["2"])
			else:
				Map.set_cell(Vector2i(maze_width/2 + 1, maze_height/2 + 1), 6, current_ID_pos["6"])
		if topRs == true:
			if topRt == true:
				Map.set_cell(Vector2i(maze_width/2 + 1, maze_height/2 - 1), 0, current_ID_pos["0"])
			else:
				Map.set_cell(Vector2i(maze_width/2 + 1, maze_height/2 - 1), 1, current_ID_pos["1"])
		else:
			if topRt == true:
				Map.set_cell(Vector2i(maze_width/2 + 1, maze_height/2 - 1), 2, current_ID_pos["2"])
			else:
				Map.set_cell(Vector2i(maze_width/2 + 1, maze_height/2 - 1), 3, current_ID_pos["3"])

#set_cell(layer: int, coords: Vector2i, source_id: int = -1, atlas_coords: Vector2i = Vector2i(-1, -1), alternative_tile: int = 0)
#set_cell(coords: Vector2i, source_id: int = -1, atlas_coords: Vector2i = Vector2i(-1, -1), alternative_tile: int = 0)
#get_cell_source_id(layer: int, coords: Vector2i, use_proxies: bool = false)
