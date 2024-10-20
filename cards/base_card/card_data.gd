class_name CardData 
extends Resource
## Data for each card. Load this into the card scene to determine cards appearance and stats.

# Type of the card. Determines how the card is used.
enum Card_Type {
	USE,
	EQUIP,
	MOVE,
	LINK,
}


@export_group("Visuals")
@export var border : Texture # TODO Card rarity, determines which card is being used.
@export var icon : Texture ## Card Art

@export_group("Name + Description")
@export var name : String ## Name of the Card.
@export var description : String ## Card Description.

@export_group("Card Attributes")
@export var type : Card_Type 
@export var max_amount : int = 4 ## Max number of times this card can be placed in a deck.
@export var cost : int ## How much fatigue is added to the player when the card is used.
@export var movement : int = 3 ## How many tiles the card can move. By default, this value is set to 3. Should be 4 or higher for any movement cards.
@export var base_damage : int ## A cards damage without modifiers.

@export_group("Actions") # Determine if a card can or cant use a certain action type.
@export var can_use : bool = true ## If disabled, this card has no "use" function.
@export var can_move : bool = true ## If disabled, this card cannot be used to move.
@export var exhaust : bool = false ## Determines if card is exhausted when used.


func _ready() -> void:
	pass


# Use this function when using the "Use" Action
func execute():
	pass


# Updates the card description based on placeholder text.
func check_placeholders() -> String:
	var placeholder_text : Dictionary = {
		"damage" : base_damage,
		"movement" : movement,
	}
	description = description.format(placeholder_text)
	return description


# Convert card type enum to string.
func card_type_to_string() -> String:
	var key = Card_Type.keys()
	return (key[type].capitalize())
