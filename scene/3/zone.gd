extends MarginContainer


#region vars
@onready var trees = $Trees

var valley = null
var type = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	valley = input_.valley
	type = input_.type


func add_tree(input_: Dictionary) -> void:
	input_.zone = self
	
	var tree = Global.scene.tree.instantiate()
	trees.add_child(tree)
	tree.set_attributes(input_)


func reshuffle_all_trees() -> void:
	var _trees = []
	
	while trees.get_child_count() > 0:
		var tree = trees.get_child(0)
		trees.remove_child(tree)
		_trees.append(tree)
	
	_trees.shuffle()
	
	for tree in _trees:
		trees.add_child(tree)


func advance_random_tree() -> void:
	refill_update()
	var tree = trees.get_children().pick_random()
	tree.advance_zone()


func advance_all_trees() -> void:
	while trees.get_child_count() > 0:
		advance_random_tree()


func refill_update() -> void:
	if trees.get_child_count() == 0:
		var donor = Global.dict.donor.zone[type]
		var zone = valley.get(donor)
		zone.advance_all_trees()
		
		if trees.get_child_count() == 0:
			pass
#endregion
