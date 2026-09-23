extends PanelContainer

@onready var label: Label = $Label
@onready var texture_rect: TextureRect = $TextureRect

@export var slot_id: Enums.EquipmentSlot
@export var slot_name: String = ""

func _ready() -> void:
	label.text = slot_name
	EventBus.equipment_changed.connect(_on_equipment_changed)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is ItemView

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var view: ItemView = data as ItemView
	var item: ItemData = ItemDatabase.get_item(view.item_id) 
		
	if slot_id == Enums.EquipmentSlot.HEAD:
		if not item is ArmorData: return
		var armor: ArmorData = item as ArmorData
		if armor.armor_slot != Enums.ArmorSlot.HELMET: return
		PlayerData.equip_item(armor, slot_id)
		return
		
	if slot_id == Enums.EquipmentSlot.CHEST:
		if not item is ArmorData: return
		var armor: ArmorData = item as ArmorData
		if armor.armor_slot != Enums.ArmorSlot.CHESTPLATE: return
		PlayerData.equip_item(armor, slot_id)
		return
	
	if slot_id == Enums.EquipmentSlot.LEGS:
		if not item is ArmorData: return
		var armor: ArmorData = item as ArmorData
		if armor.armor_slot != Enums.ArmorSlot.LEGGINGS: return
		PlayerData.equip_item(armor, slot_id)
		return
	
	if slot_id == Enums.EquipmentSlot.FEET:
		if not item is ArmorData: return
		var armor: ArmorData = item as ArmorData
		if armor.armor_slot != Enums.ArmorSlot.BOOTS: return
		PlayerData.equip_item(armor, slot_id)
		return

func _on_equipment_changed(item: ItemData, slot: Enums.EquipmentSlot) -> void:
	if self.slot_id != slot: return
	
	if item == null:
		texture_rect.texture = null
		label.show()
	else: 
		texture_rect.texture = ItemDatabase.get_icon(item.id)
		label.hide()


func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return
	if not event.double_click: return
	
	PlayerData.unequip(slot_id)
