class_name InventoryGroup extends FoldableContainer

@onready var contents: HFlowContainer = $Contents

var item_view_scene: PackedScene = preload("res://ui/inventory/item_view.tscn")

var initial_title: String

func _ready() -> void:
	initial_title = title
	
func upsert_item(item_id: StringName, quantity: int) -> void:
	var view: ItemView = contents.get_node_or_null(NodePath(item_id))
	var texture = ItemDatabase.get_icon(item_id)

	if view != null:
		view.update_quantity(quantity)
	else:
		var item_view: ItemView = item_view_scene.instantiate()
		item_view.name = item_id
		contents.add_child(item_view)
		item_view.setup(item_id, quantity, texture)

func refresh() -> void:
	var count: int = contents.get_child_count()
	visible = count > 0
	title = "%s (%s)" % [initial_title, count]
