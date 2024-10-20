class_name CardComponent
extends Node
## Component that tracks cards for a unit. Controls all card based functions.


@export var hand : Array[CardData]
@export var draw_pile : Array[CardData] 
@export var max_hand_size : int = 6

var discard_pile : Array[CardData]

## TODO Might be temporary? Cards could be loaded from current run data list
@onready var card_dictionary : Array = GlobalDatabase.all_cards


## TODO Currently temporary for testing
func _ready() -> void:
	while draw_pile.size() < max_hand_size:
		draw_pile.append(card_dictionary[0])
		


## Draw hands until your hand is full
func fill_hand() -> void:
	while hand.size() < max_hand_size:
		draw_card(draw_pile)


## Draw card from top of a pile
func draw_card(pile : Array[CardData]) -> CardData:
	# Shuffle draw pile if it is empty.
	if pile.is_empty() and pile == draw_pile:
		shuffle()
		pile = draw_pile
	var new_card = pile.pop_back()
	print("Drawing: " + new_card.name)
	hand.append(new_card)
	return new_card



## Shuffles the discard pile and converts it to the draw pile.
func shuffle() -> void:
	print("Shuffling Deck")
	discard_pile.shuffle()
	draw_pile = discard_pile
	discard_pile = []


## Add a card to any pile.
func add_card_to_pile(pile : Array[CardData], card :CardData) -> void:
	pile.append(card)


## Function to use a card from any pile. Discards card afterward.
func use_card(use_pile : Array[CardData], card_index : int) -> void:
	if card_index >= 0 and card_index < use_pile.size():
		var used_card = use_pile[card_index]
		
		# TODO Perform the card action. May move this to UI instead.
		print("Used Card: " + used_card.name)
		pass
		
		# Remove card from pile.
		use_pile.remove_at(card_index)
		
		# Move to discard pile.
		add_card_to_pile(discard_pile, used_card)
	else:
		push_error("Invalid card index")
