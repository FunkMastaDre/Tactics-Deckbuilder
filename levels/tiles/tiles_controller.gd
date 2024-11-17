class_name TilesController
extends Node3D
## This script handles all functions related to tiles.
## Useful for functions looping through every tile.

signal movable_tile_clicked
signal cancel

@export var navigation: Navigation
@export var cursor: Cursor

var clicked_tile: Tile
var clicked_tile_pos

func create_tile(tile_pos: Vector3):
	var tile_scene = load("res://levels/tiles/tile.tscn")
	var y_offset = Vector3(0, -0.499, 0)
	var instance = tile_scene.instantiate()
	add_child(instance)
	instance.position = tile_pos + y_offset


# Turn all tiles that a unit can move to blue.
func highlight_movable_tiles(unit_tile: Vector3, movement_cost: int):
	for tile in self.get_children():
		var new_tile : Vector3 = tile.global_position
		var path : int = navigation.find_path(unit_tile, new_tile).size() - 1
		if path > movement_cost or new_tile == unit_tile:
			continue
		else:
			tile.highlight_tile()
			print("Found movable tile")


func reset_all_tiles() -> void:
	for tile in self.get_children():
		tile.reset_tile()



## Input while movement tiles are displayed
