extends Control

@onready var inventory_ui: InventoryUI = $InventoryUI
@onready var notifications_container: VBoxContainer = $NotificationsContainer

var _stack: Array[Control] = []

func _ready() -> void:
	EventBus.notification.connect(_on_notification)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		_handle_escape()
		return

	if event.is_action_pressed("inventory"):
		_toggle_panel(inventory_ui)
		return
	
	if event.is_action_pressed("profile"):
		pass
		
	if event.is_action_pressed("debug"):
		_toggle_panel($DebugUi)
		return

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


func _on_notification(text: String) -> void:
	var label: Label = Label.new()
	label.text = text
	
	notifications_container.add_child(label)
	notifications_container.move_child(label, 0)
	
	var tween: Tween = create_tween()
	label.modulate.a = 0
	tween.tween_property(label, "modulate:a", 1, .1)
	tween.tween_interval(3)
	tween.tween_property(label, "modulate:a", 0, 1)
	tween.tween_callback(label.queue_free)
