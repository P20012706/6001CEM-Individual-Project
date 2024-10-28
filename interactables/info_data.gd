extends Resource
class_name InfoData 
@export var name: String = ""
@export_multiline var description: String = ""
@export var texture: AtlasTexture
@export_enum("People", "Evidence", "Location", "NULL") var category: String
@export var dialogic_timeline_id: String = ""
