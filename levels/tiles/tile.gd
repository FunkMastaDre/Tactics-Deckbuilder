class_name Tile
extends StaticBody3D
# Base script for tiles. Imports data from g

signal tile_highlighted(tile_pos: Vector3)
signal tile_clicked(tile_pos: Vector3)
@onready var grid : Node3D = get_parent().get_parent()
@onready var cursor : Node = grid.cursor
@onready var mesh: MeshInstance3D = $Mesh



var is_highlighted : bool
var is_movable : bool


func _ready() -> void:
	mesh.transparency = 1
	pass


func _input(_event: InputEvent) -> void:
	## Emit signal if tile is clicked while highlighted.
	if Input.is_action_just_pressed("Select") and is_highlighted == true:
		if detect_cursor():
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


## Checks if cursor is selecting tiles
func detect_cursor() -> bool:
	if self.position == cursor.position and cursor.is_visible_in_tree():
		return true
	else:
		return false


func highlight_tile() -> void:
	var mat : Material = mesh.get_active_material(0)
	mesh.transparency = 0.8
	mat.albedo_color = Color.BLUE


func reset_tile() -> void:
	is_movable = false
	is_highlighted = false
	mesh.transparency = 1
