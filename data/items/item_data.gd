class_name ItemData extends Resource

var id: StringName = ""
var name: String = ""
var description: String = ""
var icon_path: String = ""

var category: Enums.ItemCategory
var tradeable = false

func can_equip_in(slot: Enums.EquipmentSlot) -> bool:
	return false
