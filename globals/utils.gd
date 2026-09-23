extends Node


func read_file(path: String) -> FileAccess:
	var file = FileAccess.open(path, FileAccess.READ)
	return file

func open_file(path: String) -> FileAccess:
	var file = FileAccess.open(path, FileAccess.READ_WRITE)
	return file
	

func read_json(path: String) -> Variant:
	var file: FileAccess = read_file(path)
	if file == null: return null
	
	var json: Variant = JSON.parse_string(file.get_as_text())
	if json == null: push_error("Error while parsing JSON")
	
	return json
