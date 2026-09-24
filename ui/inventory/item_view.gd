class_name ItemView extends PanelContainer

@onready var label: Label = $Label
@onready var texture_rect: TextureRect = $TextureRect

var item_id: StringName = &""

func setup(id: StringName, quantity: int, texture: Texture2D) -> void:
	item_id = id
	
	if texture != null and is_instance_valid(texture):
		texture_rect.texture = texture
	else:
		texture_rect.texture = ItemDatabase.get_placeholder_icon()
	
	mouse_entered.connect(EventBus.item_hovered.emit.bind(item_id, true))
	mouse_exited.connect(EventBus.item_hovered.emit.bind(item_id, false))
	update_quantity(quantity)

func update_quantity(quantity: int) -> void:
	if quantity <= 1: label.text = ""
	else: label.text = str(quantity)

func _get_drag_data(at_position: Vector2) -> Variant:
	self.modulate = Color(1,1,1,0.3)

	var control: Control = Control.new()
	var icon:TextureRect = TextureRect.new()
	control.add_child(icon)
	icon.texture = texture_rect.texture
	icon.custom_maximum_size = texture_rect.size
	set_drag_preview(control)
	icon.position = - texture_rect.size /2
	
	control.tree_exited.connect(func(): self.modulate = Color.WHITE)
	
	return ItemDatabase.get_item(item_id)

func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton: return
	if not event.double_click: return
	
	var item = ItemDatabase.get_item(item_id)
	if item.category != Enums.ItemCategory.ARMOR: return
	
	PlayerData.equip_armor(item)
