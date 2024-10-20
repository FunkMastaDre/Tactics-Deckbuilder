class_name Card
extends Control
## Base Card Script. Loads data from CardData resource to determine properties.

signal card_clicked

@export var card_data : CardData : set = set_card

var hand : HBoxContainer

# Card Data Values
@onready var panel: Panel = $Panel
@onready var namelabel: Label = $VBoxContainer/Name
@onready var icon: TextureRect = $VBoxContainer/Icon
@onready var description: Label = $VBoxContainer/Description
@onready var cost: Label = $VBoxContainer/HBoxContainer/Cost
@onready var type: Label = $VBoxContainer/HBoxContainer/Type

# Action menu
var action_menu : Control
var has_action_ui : bool = false

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	# Set hand variable to Hand if card node is in gameplay scene.
	if get_parent().name == "Hand":
		hand = get_parent()


# Changes card graphics based on data.
func set_card(value : CardData) -> void:
	if not is_node_ready():
		await ready
	
	card_data = value
	self.name = card_data.name
	namelabel.text = card_data.name
	description.text = card_data.check_placeholders()
	icon.texture = card_data.icon
	cost.text = str(card_data.cost)
	type.text = card_data.card_type_to_string()


func add_action_ui():
	var action_ui = preload("res://ui/card_action_menu/card_action_menu.tscn")
	var instance = action_ui.instantiate()
	add_child(instance)
	has_action_ui = true
	action_menu = instance


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and has_action_ui:
		card_clicked.emit()
		action_menu.show()


func on_mouse_entered() -> void:
	Events.ui_element_mouse_entered.emit()
	print("mouse entered card")


func hide_action_ui():
	action_menu.hide()
