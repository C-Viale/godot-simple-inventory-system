class_name ArmorData extends ItemData

var armor_slot: Enums.ArmorSlot 
var defense: int = 0

func get_armor_slot_name() -> String:
	match self.armor_slot:
		Enums.ArmorSlot.HELMET: return "Helmet"
		Enums.ArmorSlot.CHESTPLATE: return "Chestplate"
		Enums.ArmorSlot.LEGGINGS: return "Leggings"
		Enums.ArmorSlot.BOOTS: return "Boots"
		_: return ""
