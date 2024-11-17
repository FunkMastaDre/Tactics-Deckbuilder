class_name Cursor
extends Sprite3D
## Base script for Cursor. Follows the mouse based on tiles

const y_offset = Vector3(0, -0.49, 0)

@onready var tile_detection: RayCast3D = $"Tile Detection"



func _ready() -> void:
	Events.ui_element_mouse_entered.connect(_hide_cursor, CONNECT_DEFERRED)

## Connect any signals from the tile to the cursor.
func connect_tile_signals(tiles: Node3D):
	for tile in tiles.get_children():
		tile.tile_highlighted.connect(_on_tile_highlighted)

func _on_tile_highlighted(tile_pos: Vector3):
	self.position = tile_pos


func _hide_cursor():
	self.hide()


func _show_cursor():
	self.show()


func get_current_tile() -> Tile:
	tile_detection.force_raycast_update()
	var collider = tile_detection.get_collider()
	return collider


func movable_tile_check() -> bool:
	if get_current_tile().is_highlighted and get_current_tile().is_movable:
		return true
	else:
		return false
