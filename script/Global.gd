extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_node()
	init_scene()


func init_arr() -> void:
	arr.element = ["ice", "wind", "fire", "earth"]
	arr.rank = [1, 2, 3, 4, 5]#, 6]
	arr.root = ["ice", "fire"]
	arr.crown = ["earth", "wind"]
	arr.fruit = ["mana", "emblem"]
	arr.kind = ["seed"]
	arr.windrose = ["nw", "ne", "sw", "se"]
	arr.branch = ["root", "crown", "fruit", "trunk"]


func init_num() -> void:
	num.index = {}
	num.index.tree = 0


func init_dict() -> void:
	init_chain()
	init_branch()
	init_neighbor()


func init_chain() -> void:
	dict.chain = {}
	dict.chain.zone = {}
	dict.chain.zone["wasteland"] = "sanctuary"
	dict.chain.zone["sanctuary"] = "oasis"
	dict.chain.zone["oasis"] = "wasteland"
	
	dict.donor = {}
	dict.donor.zone = {}
	dict.donor.zone["sanctuary"] = "wasteland"
	dict.donor.zone["oasis"] = "sanctuary"


func init_branch() -> void:
	dict.branch = {}
	dict.branch.windrose = {}
	dict.branch.windrose["root"] = {}
	dict.branch.windrose["root"]["ne"] = 2
	dict.branch.windrose["root"]["se"] = 0
	dict.branch.windrose["root"]["sw"] = 1
	dict.branch.windrose["root"]["nw"] = 3
	dict.branch.windrose["crown"] = {}
	dict.branch.windrose["crown"]["ne"] = 1
	dict.branch.windrose["crown"]["se"] = 3
	dict.branch.windrose["crown"]["sw"] = 2
	dict.branch.windrose["crown"]["nw"] = 0
	dict.branch.windrose["fruit"] = {}
	dict.branch.windrose["fruit"]["ne"] = 0
	dict.branch.windrose["fruit"]["se"] = 2
	dict.branch.windrose["fruit"]["sw"] = 3
	dict.branch.windrose["fruit"]["nw"] = 1
	dict.branch.windrose["trunk"] = {}
	dict.branch.windrose["trunk"]["ne"] = 3
	dict.branch.windrose["trunk"]["se"] = 1
	dict.branch.windrose["trunk"]["sw"] = 0
	dict.branch.windrose["trunk"]["nw"] = 2


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]



func init_node() -> void:
	node.game = get_node("/root/Game")


func init_scene() -> void:
	scene.pantheon = load("res://scene/1/pantheon.tscn")
	scene.god = load("res://scene/1/god.tscn")
	
	scene.tree = load("res://scene/3/tree.tscn")
	scene.branch = load("res://scene/3/branch.tscn")
	
	scene.token = load("res://scene/4/token.tscn")


func init_vec():
	vec.size = {}
	vec.size.sixteen = Vector2(16, 16)
	vec.size.number = Vector2(vec.size.sixteen)
	
	vec.size.token = Vector2(32, 32)#Vector2(20, 20)
	vec.size.branch = Vector2(vec.size.token * 4)
	vec.size.tree = Vector2(vec.size.branch * 4)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.tree = {}
	color.tree.selected = Color.from_hsv(160 / h, 0.6, 0.7)
	color.tree.unselected = Color.from_hsv(0 / h, 0.4, 0.9)


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var _parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null
