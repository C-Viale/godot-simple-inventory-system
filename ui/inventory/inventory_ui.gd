class_name InventoryUI extends Control

@onready var inventory_tabs: InventoryTabs = $MarginContainer/PanelContainer/HBoxContainer/InventoryTabs
@onready var item_tooltip: ItemTooltip = $ItemTooltip

var item_view_scene: PackedScene = preload("res://ui/inventory/item_view.tscn")

func _ready() -> void:
	EventBus.inventory_updated.connect(_refresh)
	EventBus.item_hovered.connect(_on_hover_item)
	_refresh()

func _refresh() -> void:
	for item_id in PlayerData.inventory_data:
		inventory_tabs.upsert_item(item_id, PlayerData.inventory_data[item_id])
	
	inventory_tabs.refresh()

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if item_tooltip.visible:
			item_tooltip.global_position = get_global_mouse_position() + Vector2(32,32)

func _on_hover_item(item_id: StringName, hovered: bool) -> void:
	if hovered:
		item_tooltip.set_process_mode(Node.PROCESS_MODE_INHERIT)
		item_tooltip.set_data(item_id)
		item_tooltip.show()
	else:
		item_tooltip.hide()
		item_tooltip.set_process_mode(Node.PROCESS_MODE_DISABLED)
