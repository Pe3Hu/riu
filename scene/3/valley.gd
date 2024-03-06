extends MarginContainer


#region vars
@onready var sanctuary = $Zones/Sanctuary
@onready var wasteland = $Zones/Wasteland
@onready var oasis = $Zones/Oasis

var god = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	god = input_.god
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_zones()
	init_starter_trees()
	next_turn()


func init_zones() -> void:
	for key in Global.dict.chain.zone:
		var input = {}
		input.valley = self
		input.type = key
		var zone = get(key)
		zone.set_attributes(input)


func init_starter_trees() -> void:
	var root = Global.arr.root.pick_random()
	var roots = {}
	var n = 12
	var m = 2
	var k = 4
	
	for _root in Global.arr.root:
		roots[_root] = m
		
		if root == _root:
			roots[_root] += k
		
		n -= roots[_root]
		
		for _i in roots[_root]:
			var input = {}
			var windrose = Global.arr.windrose.pick_random()
			input.branchs = {}
			input.branchs[windrose] = {}
			input.branchs[windrose].root = {}
			input.branchs[windrose].root.type = "element"
			input.branchs[windrose].root.subtype = _root
			input.branchs[windrose].root.value = 1
			input.branchs[windrose].fruit = {}
			input.branchs[windrose].fruit.type = "point"
			input.branchs[windrose].fruit.subtype = "mana"
			input.branchs[windrose].fruit.value = 1
			wasteland.add_tree(input)
	
	for _i in n:
		var input = {}
		input.branchs = {}
		wasteland.add_tree(input)
#endregion


func next_turn() -> void:
	for _i in 3:
		refill_oasis()
		desolate_oasis()
	
	refill_oasis()


func refill_oasis() -> void:
	var capacity = {}
	capacity.current = 4
	capacity.limit = 10
	var zone = get(Global.dict.donor.zone[oasis.type])
	
	while oasis.trees.get_child_count() < capacity.current:
		zone.advance_random_tree()


func desolate_oasis() -> void:
	oasis.advance_all_trees()
