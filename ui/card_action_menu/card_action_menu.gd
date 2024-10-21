extends Control
# This menu appears when clicking on a card during gameplay.
# Actions are determined by card properties.

var card : Node
var data : CardData

@onready var action_container: VBoxContainer = $ActionContainer

func _ready() -> void:
	card = get_parent()
	# Check to see if card parent is actually a card.
	if card is not Card:
		printerr("Action menu not attatched to card")
		return
	
	# Hide UI. It should be shown if a card is clicked on.
	self.hide()
	
	# Create Buttons based on actions.
	data = card.card_data
	if data.can_move:
		add_button("Move")
	if data.can_use:
		add_button("Use")


func add_button(action_name : String):
	## Create a new button based on action_name parameter.
	var button_scene = preload("res://ui/card_action_menu/card_action_button.tscn")
	var button = button_scene.instantiate()
	button.text = action_name
	button.name = action_name
	button.data = data
	action_container.add_child(button)
