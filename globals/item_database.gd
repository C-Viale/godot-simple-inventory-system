extends Node

var _items: Dictionary[StringName, ItemData] = {}
var _icons: Dictionary[StringName, Texture2D] = {}

func get_item(item_id: StringName) -> ItemData:
	return _items.get(item_id)

func has_item(item_id: StringName) -> bool:
	return _items.has(item_id)

func get_icon(item_id: StringName) -> Texture2D:
	if not _items.has(item_id): return null
	if _icons.has(item_id): return _icons[item_id]

	var icon_path = _items[item_id].icon_path
	if icon_path.is_empty(): return null

	var path: String = "res://assets/items/%s" % icon_path
	var texture: Texture2D = load(path) as Texture2D
	
	if texture == null:
		push_warning("ItemDatabase: missing icon at %s" % path)
		return null
	
	_icons[item_id] = texture
	return texture

func get_placeholder_icon() -> Texture2D:
	var id: StringName = &"placeholder"
	if _icons.has(id): return _icons[id]
	var texture: Texture2D = load("res://assets/items/placeholder.png") as Texture2D
	_icons[id] = texture
	return texture


func _ready() -> void:
	_load_weapons()
	_load_armor()
	_load_items()

func _get_file_lines(path: String) -> PackedStringArray:
	var file: FileAccess = Utils.read_file(path)
	return file.get_as_text().split("\n")

func _load_weapons() -> void:	
	var lines = _get_file_lines("res://data/db/weapons.txt")
	
	for line in lines:
		if line.is_empty(): continue
		
		var data = line.split(";")
		var weapon = WeaponData.new()
		var item_id = StringName(data[0].strip_edges())
		
		weapon.id = item_id
		weapon.name = data[3].strip_edges()
		weapon.description = data[4].strip_edges()
		weapon.icon_path = data[5].strip_edges()
		weapon.category = Enums.ItemCategory.WEAPON
		weapon.tradeable = false
		weapon.damage = int(data[2])
		
		match data[1].strip_edges():
			"SWORD": weapon.weapon_type = Enums.WeaponType.SWORD
			"AXE": weapon.weapon_type = Enums.WeaponType.AXE
			"BOW": weapon.weapon_type = Enums.WeaponType.BOW
			"HAMMER": weapon.weapon_type = Enums.WeaponType.HAMMER
			
		_items[item_id] = weapon

func _load_armor() -> void:	
	var lines = _get_file_lines("res://data/db/armor.txt")
	
	for line in lines:
		if line.is_empty(): continue
		
		var data = line.split(";")
		var armor = ArmorData.new()
		var item_id = StringName(data[0].strip_edges())
		
		armor.id = item_id
		armor.name = data[3].strip_edges()
		armor.description = data[4].strip_edges()
		armor.icon_path = data[5].strip_edges()
		armor.category = Enums.ItemCategory.ARMOR
		armor.tradeable = false
		armor.defense = int(data[2])
		
		match data[1].strip_edges():
			"HELMET": armor.armor_slot = Enums.ArmorSlot.HELMET
			"CHESTPLATE": armor.armor_slot = Enums.ArmorSlot.CHESTPLATE
			"LEGGINGS": armor.armor_slot = Enums.ArmorSlot.LEGGINGS
			"BOOTS": armor.armor_slot = Enums.ArmorSlot.BOOTS
		
		_items[item_id] = armor

func _load_items() -> void:	
	var lines = _get_file_lines("res://data/db/items.txt")
	
	for line in lines:
		if line.is_empty(): continue
		
		var data = line.split(";")
		var item = ItemData.new()
		var item_id = StringName(data[0].strip_edges())
		
		item.id = item_id
		item.name = data[2].strip_edges()
		item.description = data[3].strip_edges()
		item.icon_path = data[4].strip_edges()
		item.tradeable = false
		
		match data[1].strip_edges():
			"RESOURCE": item.category = Enums.ItemCategory.RESOURCE
			"KEY": item.category = Enums.ItemCategory.KEY
			"TOOL": item.category = Enums.ItemCategory.TOOL
		
		_items[item_id] = item
