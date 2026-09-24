class_name InventoryTabs extends TabContainer

@onready var resources = $Resources
@onready var equipments = $Equipments
@onready var recipes = $Recipes
@onready var keys = $Keys

var item_view_scene: PackedScene = preload("res://ui/inventory/item_view.tscn")

func upsert_item(item_id: StringName, quantity: int) -> void:
	var item_data = ItemDatabase.get_item(item_id)
	if item_data == null: return
	
	var grid: HFlowContainer = _get_grid(item_data.category)
	var view: ItemView = grid.get_node_or_null(NodePath(item_id))
	
	var texture = ItemDatabase.get_icon(item_id)
	
	if view != null:
		view.update_quantity(quantity)
	else:
		var item_view: ItemView = item_view_scene.instantiate()
		item_view.name = item_id
		grid.add_child(item_view)
		item_view.setup(item_id, quantity, texture)

func _get_grid(category: Enums.ItemCategory) -> HFlowContainer:
	match category:
		Enums.ItemCategory.RESOURCE: return resources
		Enums.ItemCategory.KEY: return keys
		Enums.ItemCategory.RECIPE: return recipes
		
		Enums.ItemCategory.WEAPON: return equipments
		Enums.ItemCategory.OFFHAND: return equipments
		Enums.ItemCategory.TOOL: return equipments
		Enums.ItemCategory.ARMOR: return equipments
		Enums.ItemCategory.CONSUMABLE: return equipments
		
	return resources
