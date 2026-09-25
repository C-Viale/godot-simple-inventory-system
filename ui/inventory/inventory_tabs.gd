class_name InventoryTabs extends TabContainer

@onready var resources: HFlowContainer = $Resources
@onready var recipes: HFlowContainer = $Recipes
@onready var keys: HFlowContainer = $Keys

@onready var armor: InventoryGroup = $Equipments/VBoxContainer/Armor
@onready var weapons: InventoryGroup = $Equipments/VBoxContainer/Weapons
@onready var offhand: InventoryGroup = $Equipments/VBoxContainer/Offhand
@onready var tools: InventoryGroup = $Equipments/VBoxContainer/Tools
@onready var consumables: InventoryGroup = $Equipments/VBoxContainer/Consumables

var item_view_scene: PackedScene = preload("res://ui/inventory/item_view.tscn")

func upsert_item(item_id: StringName, quantity: int) -> void:
	var item_data = ItemDatabase.get_item(item_id)
	if item_data == null: return
	
	var grid: Control = _get_grid(item_data.category)
	
	if grid is InventoryGroup:
		grid.upsert_item(item_id, quantity)
		return
	
	var view: ItemView = grid.get_node_or_null(NodePath(item_id))
	
	var texture = ItemDatabase.get_icon(item_id)
	
	if view != null:
		view.update_quantity(quantity)
	else:
		var item_view: ItemView = item_view_scene.instantiate()
		item_view.name = item_id
		grid.add_child(item_view)
		item_view.setup(item_id, quantity, texture)

func _get_grid(category: Enums.ItemCategory) -> Control:
	match category:
		Enums.ItemCategory.RESOURCE: return resources
		Enums.ItemCategory.KEY: return keys
		Enums.ItemCategory.RECIPE: return recipes
		
		Enums.ItemCategory.WEAPON: return weapons
		Enums.ItemCategory.OFFHAND: return offhand
		Enums.ItemCategory.TOOL: return tools
		Enums.ItemCategory.ARMOR: return armor
		Enums.ItemCategory.CONSUMABLE: return consumables

	return resources

func refresh() -> void:
	armor.refresh()
	weapons.refresh()
	offhand.refresh()
	tools.refresh()
	consumables.refresh()
