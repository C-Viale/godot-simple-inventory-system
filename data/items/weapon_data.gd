class_name WeaponData extends ItemData

var weapon_type: Enums.WeaponType 
var damage: int = 0

func get_weapon_type_name() -> String:
	match self.weapon_type:
		Enums.WeaponType.SWORD: return "Sword"
		Enums.WeaponType.AXE: return "Axe"
		Enums.WeaponType.BOW: return "Bow"
		Enums.WeaponType.HAMMER: return "Hammer"
		_: return ""
	

static func from_item_data(data: ItemData) -> WeaponData:
	var weapon: WeaponData = WeaponData.new()
	weapon.id = data.id
	weapon.name = data.name
	weapon.description = data.description
	weapon.icon_path = data.icon_path
	weapon.category = data.category
	return weapon
