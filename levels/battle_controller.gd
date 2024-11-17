extends Node
class_name BattleController
## Controls nearly everything in the current battle using states.
## Calls down to most other nodes

@export_group("Nodes")
@export var camera : Node3D
@export var grid : Node3D
@export var units : Node3D
@export var ui : CanvasLayer

@onready var state_chart: StateChart = $StateChart

func _ready() -> void:
	Events.card_action_button_pressed.connect(_on_card_action_button_pressed)
	units.unit_moved.connect(transition)

func transition(transition: StringName):
	state_chart.send_event(transition)


## Trainsition to a state based on what card_action menu is pressed
func _on_card_action_button_pressed(action: String, data: CardData):
	if action == "Move":
		transition("move_card_selected")
		var movement_cost = data.movement
		var current_tile = units.current_unit.get_current_tile()
		var tile_pos = current_tile.global_position
		grid.tiles.highlight_movable_tiles(tile_pos, movement_cost)


#region PlayerTurn

#region Base State
func _on_base_state_entered() -> void:
	ui.display_all_ui()
	grid.tiles.reset_all_tiles()
#endregion

#region Movement (Compound)
func _on_moving_state_entered() -> void:
	grid.tiles.reset_all_tiles
	var new_tile = grid.tiles.clicked_tile_pos
	units.move_unit_to_tile(new_tile)


#region Movement Preview (Atomic)
func _on_movement_preview_state_entered() -> void:
	ui.display_hand_ui(false)


func _on_movement_preview_state_input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		var cursor = grid.cursor
		var tiles = grid.tiles
		if cursor.movable_tile_check():
			tiles.clicked_tile = cursor.get_current_tile()
			tiles.clicked_tile_pos = tiles.clicked_tile.global_position
			transition("on_moving")
			print("Tile Clicked")
	if event.is_action_pressed("Cancel"):
		transition("on_cancel")
#endregion
#endregion
#endregion
