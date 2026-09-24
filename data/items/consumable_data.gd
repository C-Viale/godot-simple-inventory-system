class_name ConsumableData extends ItemData

var consumable_type: Enums.ConsumableType

func can_equip_in(slot: Enums.EquipmentSlot) -> bool:
	match slot:
		Enums.EquipmentSlot.QUICK_1,\
		Enums.EquipmentSlot.QUICK_2,\
		Enums.EquipmentSlot.QUICK_3: return true
		_: return false
