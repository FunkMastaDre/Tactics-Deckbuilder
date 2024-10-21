class_name Grid
extends Node3D
## Base script for all grid related tasks.

const TILE_SIZE = 1.0 ## Size of each tile on grid in meters.

@export var navigation: Node3D
@export var tiles: Node3D
@export var grid_map: GridMap
@export var cursor: Sprite3D




func _ready() -> void:
	navigation._add_points()
	navigation._connect_all_points()
	spawn_tiles()
	cursor.connect_tile_signals(tiles)



func spawn_tiles():
	for point in navigation.points:
		tiles.create_tile(point)
