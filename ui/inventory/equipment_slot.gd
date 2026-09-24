extends PanelContainer

@onready var label: Label = $Label
@onready var texture_rect: TextureRect = $TextureRect

@export var slot: Enums.EquipmentSlot
@export var slot_name: String = ""

func _ready() -> void:
	label.text = slot_name
	EventBus.equipment_changed.connect(_on_equipment_changed)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if not data is ItemData: return false
	return data.can_equip_in(slot)

func _drop_data(at_position: Vector2, item: Variant) -> void:
	if item is ArmorData: 
		PlayerData.equip_armor(item)
		return
	
	if item is WeaponData:
		PlayerData.equip_weapon(item, slot)
		return
	
	if item is ConsumableData:
		PlayerData.equip_quick(item, slot)
		return
	

func _on_equipment_changed(item: ItemData, slot: Enums.EquipmentSlot) -> void:
	if self.slot != slot: return
	
	if item == null:
		texture_rect.texture = null
		label.show()
	else: 
		texture_rect.texture = ItemDatabase.get_icon(item.id)
		label.hide()

func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return
	if not event.double_click: return
	
	PlayerData.unequip(slot)
