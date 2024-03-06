extends MarginContainer


#region vars
@onready var soil = $HBox/Soil
@onready var tokens = $HBox/Tokens

var proprietor = null
var windrose = null
var root = null
var crown = null
var fruit = null
var trunk = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	proprietor = input_.proprietor
	windrose = input_.windrose
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	#custom_minimum_size = Vector2(Global.vec.size.branch)
	if proprietor != null:
		proprietor.windroses[windrose] = self
	
	init_soil(input_)
	init_tokens(input_)


func init_soil(input_: Dictionary) -> void:
	if input_.has("soil"):
		input_.tokens = []
		input_.branch = self
		var input = {}
		input.type = "point"
		input.subtype = "mana"
		input.value = 1
		input_.tokens.append(input)
		soil.set_attributes(input_)
	else:
		input_.branch = self
		input_.tokens = []
		soil.set_attributes(input_)
		soil.visible = false


func init_tokens(input_: Dictionary) -> void:
	var types = []
	types.append_array(Global.arr.branch)
	types.sort_custom(func(a, b): return Global.dict.branch.windrose[a][windrose] < Global.dict.branch.windrose[b][windrose])
	
	for type in types:
		add_token(type, input_.subtypes)


func add_token(subtype_: String, subtypes_: Dictionary) -> void:
	var input = {}
	input.proprietor = self
	
	if subtypes_.has(subtype_):
		input = subtypes_[subtype_]
		input.proprietor = self
	else:
		input.type = "point"#"branch"
		input.subtype = "empty"
		#input.value = round(input.value)
	
	var token = Global.scene.token.instantiate()
	tokens.add_child(token)
	token.set_attributes(input)
	set(subtype_, token)
#endregion
