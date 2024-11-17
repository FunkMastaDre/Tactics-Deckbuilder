class_name Unit_Controller
extends Node3D
# Main script for all units. Controls all game logic such as turn order.

signal unit_moved

@export var navigation : Navigation
@export var current_unit: Unit
@export var tiles: TilesController
@export var cursor: Cursor

var turn_order = []

func _ready() -> void:
	snap_all_units()


func snap_all_units():
	for alignment in self.get_children():
		for unit in alignment.get_children():
			var closest_position = navigation.get_closest_tile(unit.global_position)
			unit.snap_to_tile(closest_position)


func move_unit_to_tile(new_tile: Vector3):
	var current_tile = navigation.get_closest_tile(current_unit.global_position)
	var path = navigation.find_path(current_tile, new_tile)
	current_unit.follow_path(path)
