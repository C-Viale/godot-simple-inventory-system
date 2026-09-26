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
	if not armor is ArmorData: return
	
	var slot: Enums.EquipmentSlot
	
	match armor.armor_slot:
		Enums.EquipmentSlot.HEAD: 
			slot = Enums.EquipmentSlot.HEAD
			head = armor
		Enums.EquipmentSlot.CHEST: 
			slot = Enums.EquipmentSlot.CHEST
			chest = armor
		Enums.EquipmentSlot.LEGS: 
			slot = Enums.EquipmentSlot.LEGS
			legs = armor
		Enums.EquipmentSlot.FEET: 
			slot = Enums.EquipmentSlot.FEET
			feet = armor
	
	EventBus.equipment_changed.emit(armor, slot)

func equip_weapon(weapon: WeaponData, slot: Enums.EquipmentSlot) -> void:
	if slot == Enums.EquipmentSlot.WEAPON_1:
		if weapon_2 != null and weapon_2.id == weapon.id:
			weapon_2 = null
			EventBus.equipment_changed.emit(null, Enums.EquipmentSlot.WEAPON_2)
		
		weapon_1 = weapon
		EventBus.equipment_changed.emit(weapon, Enums.EquipmentSlot.WEAPON_1)
	
	if slot == Enums.EquipmentSlot.WEAPON_2:
		if weapon_1 != null and weapon_1.id == weapon.id:
			weapon_1 = null
			EventBus.equipment_changed.emit(null, Enums.EquipmentSlot.WEAPON_1)
		
		weapon_2 = weapon
		EventBus.equipment_changed.emit(weapon, Enums.EquipmentSlot.WEAPON_2)
	
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

func equip_quick(consumable: ConsumableData, slot: Enums.EquipmentSlot) -> void:
	match slot:
		Enums.EquipmentSlot.QUICK_1: quick_slot_1 = consumable
		Enums.EquipmentSlot.QUICK_2: quick_slot_2 = consumable
		Enums.EquipmentSlot.QUICK_3: quick_slot_3 = consumable
	
	EventBus.equipment_changed.emit(consumable, slot)

func add_item(id: StringName, count: int) -> void:
	if id.is_empty() or count <= 0: return
	inventory_data[id] = inventory_data.get(id, 0) + count
	EventBus.inventory_updated.emit()
	EventBus.notification.emit("%s x%s" % [id, count])

func decrement_item(id: StringName, count: int) -> void:
	if id.is_empty() or count <= 0: return
	var new_value: int = inventory_data.get(id, 0) - count
	inventory_data[id] = maxi(new_value, 0)
	EventBus.inventory_updated.emit()

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
