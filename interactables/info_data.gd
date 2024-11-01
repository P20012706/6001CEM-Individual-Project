extends Resource
class_name InfoData 
@export var name: String = ""
@export_multiline var description: String = ""
@export var path: String = ""
@export var length: int 
@export var height: int 
@export_enum("People", "Evidence", "Location") var category: String

