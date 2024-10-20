## Keeps track of cards in the current player unit's hand.
extends HBoxContainer

var card_scene = preload("res://cards/base_card/card.tscn")

func _ready() -> void:
	pass



func draw_card(drawn_card : CardData) -> void:
	var instance = card_scene.instantiate()
	instance.card_data = drawn_card
	add_child(instance)
	instance.add_action_ui()
	instance.card_clicked.connect(hide_action_menus)


func update_hand_ui(hand : Array[CardData]) -> void:
	# Add all cards to hand
	for card in hand:
		var instance = card_scene.instantiate()
		instance.card_data = card
		add_child(instance)
		instance.add_action_ui()
		reconnect_card_signals()


func clear_hand_ui() -> void:
	var card_count = self.get_child_count()
	if card_count > 0:
		for child in self.get_children():
			child.free()


func remove_card(index : int) -> void:
	var hand = self.get_children()
	hand[index].queue_free()
	


func hide_action_menus() -> void:
	var hand = self.get_children()
	for card in hand:
		card.hide_action_ui()


func reconnect_card_signals() -> void:
	var hand = self.get_children()
	# Reconnect signal if if needed.
	for card in hand:
		if !card.is_connected("card_clicked", hide_action_menus):
				card.card_clicked.connect(hide_action_menus)
