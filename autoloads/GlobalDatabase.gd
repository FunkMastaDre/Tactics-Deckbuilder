extends Node
## Keeps tracks of all cards (and other items in the future) in the game.

var card_group : ResourceGroup = load("res://cards/allcards.tres")
var all_cards = card_group.load_all() 
