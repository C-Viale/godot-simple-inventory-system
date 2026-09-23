class_name ItemTooltip extends PanelContainer

@onready var title: Label = $VBoxContainer/Title
@onready var description: RichTextLabel = $VBoxContainer/Description
@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect

@onready var stats_container: VBoxContainer = $VBoxContainer/StatsContainer
@onready var stats_separator: HSeparator = $VBoxContainer/StatsSeparator

func set_data(item_id: StringName) -> void:
	_clear_stats()
	var item = ItemDatabase.get_item(item_id)
	var icon = ItemDatabase.get_icon(item_id)
	
	if icon != null: texture_rect.texture = icon
	else : texture_rect.texture = ItemDatabase.get_placeholder_icon()
	
	if item is WeaponData:
		stats_separator.visible = true
		_attach_stat("Type", item.get_weapon_type_name())
		_attach_stat("Damage", str(item.damage))
	
	title.text = item.name
	description.text = item.description
	
	await get_tree().process_frame
	
	reset_size()
	

func _attach_stat(name:String, value:String) -> void:
	var stat_label: Label = Label.new()
	stat_label.text = "%s: %s" % [name , value]
	stats_container.add_child(stat_label)

func _clear_stats() -> void:
	stats_separator.visible = false
	for child in stats_container.get_children():
		child.queue_free()
