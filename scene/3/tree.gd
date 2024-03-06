extends MarginContainer


#region vars
@onready var branchs = $Branchs

var zone = null
var windroses = {}
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	zone = input_.zone
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	#custom_minimum_size = Vector2(Global.vec.size.tree)
	init_branchs(input_)


func init_branchs(input_: Dictionary) -> void:
	for windrose in Global.arr.windrose:
		var input = {}
		input.proprietor = self
		input.windrose = windrose
		input.subtypes = {}
		
		if input_.branchs.has(windrose):
			input.subtypes = input_.branchs[windrose]
		
		var branch = Global.scene.branch.instantiate()
		branchs.add_child(branch)
		branch.set_attributes(input)
#endregion


func advance_zone() -> void:
	zone.trees.remove_child(self)
	
	var type = Global.dict.chain.zone[zone.type]
	zone = zone.valley.get(type)
	zone.trees.add_child(self)
