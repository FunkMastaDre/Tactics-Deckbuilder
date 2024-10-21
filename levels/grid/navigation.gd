class_name Navigation
extends Node3D
# Base scene for Navigation related grid tasks
# Handles Astar pathfinding


const y_offset = Vector3.UP

var astar: AStar3D = AStar3D.new()
var points: Dictionary = {}

@onready var grid: Node3D = get_parent()
@onready var gridmap: GridMap = grid.grid_map

func _ready() -> void:
	pass


# DEBUG
#func _input(_event: InputEvent) -> void:
#	if Input.is_action_just_pressed("debug4") and OS.is_debug_build():
#		var marker = preload("res://point_marker.tscn")
#		for point in points:
#			var instance = marker.instantiate()
#			add_child(instance)
#			instance.position = point


## Add all points from gridmap
func _add_points() -> void:
	for point in gridmap.get_used_cells():
		add_point(point)


## Add a single astar point using gridmap coordinates
func add_point(point: Vector3) -> void:
		var id = astar.get_available_point_id()
		var point_pos = to_global(gridmap.map_to_local(point)) + y_offset
		astar.add_point(id, point_pos)
		points[point_pos] = id


## Connect a single point to a point in each direction if possible
func connect_point(id: int) -> void:
	var point_pos: Vector3 = astar.get_point_position(id)
	var directions: Array = [Vector3.FORWARD, Vector3.LEFT, Vector3.BACK, Vector3.RIGHT]
	for direction in directions:
		var potential_neighbor = point_pos + (direction * grid.TILE_SIZE)
		if points.has(potential_neighbor):
			var current_id = points[point_pos]
			var neighbor_id = points[potential_neighbor]
			if not astar.are_points_connected(current_id, neighbor_id):
				astar.connect_points(current_id, neighbor_id)


# Connect all points in the astar grid
func _connect_all_points() -> void:
	for point in points.values():
		connect_point(point)


# Returns a path between two points
func find_path(from: Vector3, to: Vector3) -> Array:
	var start = astar.get_closest_point(from)
	var end = astar.get_closest_point(to)
	return astar.get_point_path(start, end)


# Turns off an astar point. Useful if a unit is standing there.
func disable_point(id: int) -> void:
	astar.set_point_disabled(id)


func get_closest_tile(point_pos: Vector3) -> Vector3:
	var closest_point = astar.get_closest_point(point_pos)
	var closest_tile = astar.get_point_position(closest_point)
	return closest_tile
