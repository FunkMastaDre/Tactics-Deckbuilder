class_name UI
extends CanvasLayer
## UI for standard gameplay

@export var unit_controller: Node3D

var cards: CardComponent

@onready var hand_ui: HBoxContainer = $Hand

func _ready() -> void:
	cards = unit_controller.current_unit.cards


#DEBUG
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug1"):
		hand_ui.clear_hand_ui()
		hand_ui.update_hand_ui(cards.hand)
	if Input.is_action_just_pressed("debug2"):
		add_card_to_hand()
	if Input.is_action_just_pressed("debug3"):
		if hand_ui.get_child_count() > 0:
			use_player_card(hand_ui, 0)


func add_card_to_hand():
	if cards.hand.size() < cards.max_hand_size:
		var drawn_card = cards.draw_card(cards.draw_pile)
		hand_ui.draw_card(drawn_card)


func use_player_card(pile_ui :Control, index :int):
	var pile : Array[CardData]
	if pile_ui == hand_ui:
		pile = cards.hand
	cards.use_card(pile, index)
	hand_ui.remove_card(index)


func _on_hand_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print("Test")

## Show or hide all UI
func display_all_ui(display: bool = true):
	if display:
		self.show()
	else:
		self.hide()

## Show or hide a certain UI element
func display_ui_element(element: Node, display: bool = true):
	if display:
		element.hide()
	else:
		element.hide()
