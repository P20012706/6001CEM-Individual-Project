extends Resource
class_name InfoData 
@export var name: String = ""
@export_multiline var description: String = ""
@export var path: String = ""
@export var length: int = 80
@export var height: int  = 80
@export_enum("People", "Evidence", "Location") var category: String
@export var extracted: bool 
