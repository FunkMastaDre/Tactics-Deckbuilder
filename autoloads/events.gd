extends Node
## Event bus for communicating between distant nodes using signals.
## Used in cases where connecting nodes directly would be too complicated.

## emitted if mouse touches any UI element.
signal ui_element_mouse_entered

## emitted when a card action button is pressed.
signal card_action_button_pressed(action: String, data: CardData)
