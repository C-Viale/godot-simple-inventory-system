extends Node

var username: String = "";


# INVENTORY / EQUIPMENTS
var head: ItemData = null
var chest: ItemData = null
var legs: ItemData = null
var feet: ItemData = null
var weapon_1: ItemData = null
var weapon_2: ItemData = null
var offhand: ItemData = null
var quick_slot_1: ItemData = null
var quick_slot_2: ItemData = null
var quick_slot_3: ItemData = null
var inventory_data: Dictionary[StringName, int] = {}

func equip_armor(armor: ArmorData) -> void:
	match armor.armor_slot:
		Enums.ArmorSlot.HELMET: 
			head = armor
			EventBus.equipment_changed.emit(armor, Enums.EquipmentSlot.HEAD)
		Enums.ArmorSlot.CHESTPLATE: 
			chest = armor
			EventBus.equipment_changed.emit(armor, Enums.EquipmentSlot.CHEST)
		Enums.ArmorSlot.LEGGINGS: 
			legs = armor
			EventBus.equipment_changed.emit(armor, Enums.EquipmentSlot.LEGS)
		Enums.ArmorSlot.BOOTS: 
			feet = armor
			EventBus.equipment_changed.emit(armor, Enums.EquipmentSlot.FEET)

func unequip(slot: Enums.EquipmentSlot) -> void:
	match slot:
		Enums.EquipmentSlot.HEAD: head = null
		Enums.EquipmentSlot.CHEST: chest = null
		Enums.EquipmentSlot.LEGS: legs = null
		Enums.EquipmentSlot.FEET: feet = null
		Enums.EquipmentSlot.WEAPON_1: weapon_1 = null
		Enums.EquipmentSlot.WEAPON_2: weapon_2 = null
		Enums.EquipmentSlot.OFFHAND: offhand = null
		Enums.EquipmentSlot.QUICK_1: quick_slot_1 = null
		Enums.EquipmentSlot.QUICK_2: quick_slot_2 = null
		Enums.EquipmentSlot.QUICK_3: quick_slot_3 = null

	EventBus.equipment_changed.emit(null, slot)

func equip_item(item: ItemData, slot: Enums.EquipmentSlot) -> void:
	match slot:
		Enums.EquipmentSlot.HEAD: head = item
		Enums.EquipmentSlot.CHEST: chest = item
		Enums.EquipmentSlot.LEGS: legs = item
		Enums.EquipmentSlot.FEET: feet = item
		Enums.EquipmentSlot.WEAPON_1: weapon_1 = item
		Enums.EquipmentSlot.WEAPON_2: weapon_2 = item
		Enums.EquipmentSlot.OFFHAND: offhand = item
		Enums.EquipmentSlot.QUICK_1: quick_slot_1 = item
		Enums.EquipmentSlot.QUICK_2: quick_slot_2 = item
		Enums.EquipmentSlot.QUICK_3: quick_slot_3 = item
	
	EventBus.equipment_changed.emit(item, slot)


func TEST_add_item() -> void:
	add_item(&"stone", 1)
	EventBus.inventory_updated.emit()


func add_item(id: StringName, count: int) -> void:
	if id.is_empty() or count <= 0: return
	inventory_data[id] = inventory_data.get(id, 0) + count



func _ready() -> void:
	load_data()
	

func load_data() -> void:
	var json = Utils.read_json("res://data/db/players.json")
	
	if (json == null) or (not json is Dictionary):
		return
	
	username = json.get("username", "test")
	
	var stored_inv = json.get("inventory", {})
	
	for key in stored_inv:
		inventory_data[key] = stored_inv[key]
	
	EventBus.equipment_changed.emit()
