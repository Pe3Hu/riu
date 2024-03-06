extends MarginContainer


#region vars
@onready var tokens = $Tokens

var branch = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	branch = input_.branch
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	#custom_minimum_size = Vector2(Global.vec.size.soil)
	
	init_tokens(input_)


func init_tokens(input_: Dictionary) -> void:
	for input in input_.tokens:
		add_token(input)


func add_token(input_: Dictionary) -> void:
	input_.proprietor = self
	
	var token = Global.scene.token.instantiate()
	tokens.add_child(token)
	token.set_attributes(input_)
#endregion
