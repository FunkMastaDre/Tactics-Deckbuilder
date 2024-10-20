class_name Cursor
extends Sprite3D
## Base script for Cursor. Follows the mouse based on tiles

const y_offset = Vector3(0, -0.49, 0)


func _ready() -> void:
	Events.ui_element_mouse_entered.connect(_hide_cursor, CONNECT_DEFERRED)

## Connect any signals from the tile to the cursor.
func connect_tile_signals(tiles: Node3D):
	for tile in tiles.get_children():
		tile.tile_highlighted.connect(_on_tile_highlighted)

func _on_tile_highlighted(tile_pos: Vector3):
	self.position = tile_pos


func _hide_cursor():
	Utility.show_node(self, false)


func _show_cursor():
	Utility.show_node(self)
