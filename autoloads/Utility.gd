extends Node
## General use functions that are used for many nodes.
## If a function is used in multiple scripts, it may be best to move it here.


func show_node(node: Node, is_displayed: bool = true):
	if is_displayed:
		node.show()
	else:
		node.hide()
