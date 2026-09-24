extends Node

enum ItemCategory {
	RESOURCE, # 0
	CONSUMABLE, # 1,
	KEY, # 2
	RECIPE, # 3
	WEAPON, # 4
	OFFHAND, # 5
	TOOL, # 6
	ARMOR #7
}

enum WeaponType {
	SWORD,
	AXE,
	HAMMER,
	BOW,
}

enum EquipmentSlot {
	HEAD, CHEST,LEGS, FEET,
	WEAPON_1, WEAPON_2,
	OFFHAND,
	QUICK_1, QUICK_2, QUICK_3,
}

enum ArmorSlot { HELMET, CHESTPLATE, LEGS, BOOTS }
enum OffhandType { SHIELD, BOOK }
