class_name Unit
extends CharacterBody3D
## Base class for Units.



var alignment : String
var unit_group: Node3D

@onready var cards : CardComponent = $Cards
@onready var tile_detection: RayCast3D = $"Tile Detection"
@onready var controller: Unit_Controller = get_parent().get_parent()


# DEBUG
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug4"):
		print(get_current_tile().name)

func _ready() -> void:
	set_alignment()


# Set alignment of unit based on parents name.
func set_alignment() -> void:
	if get_parent().name != null:
		alignment = get_parent().name
		unit_group = get_parent()
		pass


## Unit follows path based on ASTAR from navigation node.
func follow_path(path: Array) -> void:
	for tile in path:
		self.global_position = tile
		if tile != path[-1]:
			await get_tree().create_timer(0.2).timeout
	controller.unit_moved.emit("move_complete")


## Centers unit on its closest tile.
func snap_to_tile(tile_pos: Vector3) -> void:
	self.global_position = tile_pos


## Determine tile that unit is currently standing on
func get_current_tile() -> Tile:
	tile_detection.force_raycast_update()
	var collider = tile_detection.get_collider()
	return collider
