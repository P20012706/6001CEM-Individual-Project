extends Resource
class_name InfoData 
@export var name: String = ""
@export_multiline var description: String = ""
@export var path: String = ""
@export_enum("People", "Evidence", "Location", "NULL") var category: String

