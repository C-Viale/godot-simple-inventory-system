extends PanelContainer


func _ready() -> void:
	_populate_items()
	
	$VBoxContainer/VBoxContainer/AddButton.pressed.connect(_add_item)
	$VBoxContainer/VBoxContainer/RemoveButton.pressed.connect(_remove_item)

func _populate_items() -> void:
	for item in ItemDatabase._items:
		$VBoxContainer/VBoxContainer/OptionButton.add_item(item)


func _add_item() -> void:
	var a = $VBoxContainer/VBoxContainer/OptionButton
	var t = $VBoxContainer/VBoxContainer/LineEdit.text
	var id = a.get_item_text(a.get_selected_id())
	var qnt = 0 if t.is_empty() else int(t)
	PlayerData.add_item(id, qnt)

func _remove_item() -> void:
	var a = $VBoxContainer/VBoxContainer/OptionButton
	var t = $VBoxContainer/VBoxContainer/LineEdit.text
	var id = a.get_item_text(a.get_selected_id())
	var qnt = 0 if t.is_empty() else int(t)
	PlayerData.decrement_item(id, qnt)
