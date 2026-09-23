extends Control

@onready var inventoryUi: InventoryUI = $InventoryUI

var _stack: Array[Control] = []

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		_handle_escape()
		return

	if event.is_action_pressed("inventory"):
		_toggle_panel(inventoryUi)
		return
	
	if event.is_action_pressed("profile"):
		pass

func _handle_escape() -> void:
	if _stack.is_empty():
		return

func _toggle_panel(control: Control) -> void: 
	if control.visible: _hide_panel(control)
	else: _show_panel(control)

func _show_panel(control: Control) -> void:
	if _stack.has(control): return
	
	_stack.push_back(control)
	control.show()
	control.set_process_mode(Node.PROCESS_MODE_ALWAYS)

func _hide_panel(control: Control) -> void:
	control.hide()
	control.set_process_mode(Node.PROCESS_MODE_DISABLED)
	_stack.erase(control)
