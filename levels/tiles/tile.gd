class_name Tile
extends StaticBody3D
# Base script for tiles. Imports data from g

signal tile_highlighted(tile_pos: Vector3)
signal tile_clicked(tile_pos: Vector3)
@onready var grid : Node3D = get_parent().get_parent()
@onready var cursor : Node = grid.cursor
@onready var mesh: MeshInstance3D = $Mesh



var is_highlighted : bool


func _ready() -> void:
	mesh.transparency = 1
	pass


func _input(_event: InputEvent) -> void:
	## Emit signal if tile is clicked while highlighted.
	if Input.is_action_just_pressed("leftclick") and is_highlighted == true:
		if self.position == cursor.position and cursor.is_visible_in_tree():
			tile_clicked.emit(self.global_position)
			print("tile clicked")
		else:
			is_highlighted = false


# Emits signal if tile is highlighted.
# Signal connected to mouse cursor
func _on_mouse_entered() -> void:
	Utility.show_node(cursor)
	print("mouse entered tile")
	tile_highlighted.emit(self.global_position)
	is_highlighted = true


func _on_mouse_exited() -> void:
	is_highlighted = false
