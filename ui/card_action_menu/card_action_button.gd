class_name CardActionButton
extends Button
## This button is added to the card action menu once it is created.
## A button will be created for each action needed based on card data

func _on_pressed() -> void:
	var button_name = self.name
	Events.card_action_button_pressed.emit(button_name)
	var format_string = "CardActionMenu: %s pressed"
	var message = format_string % button_name
	print(message)
