class_name ArmorData extends ItemData

var armor_slot: Enums.ArmorSlot 
var defense: int = 0

func can_equip_in(slot: Enums.EquipmentSlot) -> bool:
	match armor_slot:
		Enums.ArmorSlot.HELMET: return slot == Enums.EquipmentSlot.HEAD
		Enums.ArmorSlot.CHESTPLATE: return slot == Enums.EquipmentSlot.CHEST
		Enums.ArmorSlot.LEGS: return slot == Enums.EquipmentSlot.LEGS
		Enums.ArmorSlot.BOOTS: return slot == Enums.EquipmentSlot.FEET
	
	return false

func get_armor_slot_name() -> String:
	match armor_slot:
		Enums.ArmorSlot.HELMET: return "Helmet"
		Enums.ArmorSlot.CHESTPLATE: return "Chestplate"
		Enums.ArmorSlot.LEGS: return "Legs"
		Enums.ArmorSlot.BOOTS: return "Boots"
		_: return ""
