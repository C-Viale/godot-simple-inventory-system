extends Node

# INVENTORY EVENTS
signal equipment_changed(item: ItemData, slot: Enums.EquipmentSlot)
signal inventory_updated()

signal item_hovered(item_id: StringName, hovered: bool)
signal equipment_hovered(item: ItemData)
