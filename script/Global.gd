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
	arr.edge = [1, 2, 3, 4, 5, 6]
	arr.symbol = ["A", "A", "A", "B", "B", "C"]


func init_num() -> void:
	num.index = {}


func init_dict() -> void:
	init_neighbor()
	init_grimoire()
	init_kit()
	


func init_grimoire() -> void:
	dict.grimoire = {}
	dict.grimoire.pages = []
	var types = ["rune", "seal", "spell", "ritual", "massif", "avatar"]
	var subtypes = ["minor", "major"]
	
	for type in types:
		for subtype in subtypes:
			var description = {}
			description.type = type
			description.subtype = subtype
			dict.grimoire.pages.append(description)


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


func init_emptyjson() -> void:
	dict.emptyjson = {}
	dict.emptyjson.title = {}
	
	var path = "res://asset/json/aroakapa_emptyjson.json"
	var array = load_data(path)
	
	for emptyjson in array:
		var data = {}
		
		for key in emptyjson:
			if key != "title":
				data[key] = emptyjson[key]
		
		dict.emptyjson.title[emptyjson.title] = data


func init_kit() -> void:
	dict.kit = {}
	dict.kit.index = {}
	dict.kit.order = {}
	
	var path = "res://asset/json/torona_kit.json"
	var array = load_data(path)
	
	for kit in array:
		var data = {}
		data.symbols = {}
		
		for key in kit:
			if key != "index" and key != "order":
				var words = key.split(" ")
				
				if words.has("symbol"):
					data.symbols[words[1]] = kit[key]
				else:
					data[key] = kit[key]
		
		
		dict.kit.index[int(kit.index)] = data
		
		if !dict.kit.order.has(kit.order):
			dict.kit.order[kit.order] = int(kit.index)



func init_node() -> void:
	node.game = get_node("/root/Game")


func init_scene() -> void:
	scene.mage = load("res://scene/1/mage.tscn")
	scene.page = load("res://scene/1/page.tscn")
	scene.recipe = load("res://scene/1/recipe.tscn")
	
	scene.dice = load("res://scene/2/dice.tscn")
	scene.facet = load("res://scene/2/facet.tscn")


func init_vec():
	vec.size = {}
	vec.size.letter = Vector2(20, 20)
	vec.size.icon = Vector2(48, 48)
	vec.size.number = Vector2(5, 32)
	
	vec.size.aspect = Vector2(32, 32)
	vec.size.box = Vector2(100, 100)
	vec.size.bar = Vector2(120, 12)
	vec.size.page = Vector2(32, 32)
	vec.size.facet = Vector2(48, 48)
	vec.size.sixteen = Vector2(16, 16)
	
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.indicator = {}
	color.indicator.health = {}
	color.indicator.health.fill = Color.from_hsv(0, 1, 0.9)
	color.indicator.health.background = Color.from_hsv(0, 0.25, 0.9)
	color.indicator.endurance = {}
	color.indicator.endurance.fill = Color.from_hsv(0.33, 1, 0.9)
	color.indicator.endurance.background = Color.from_hsv(0.33, 0.25, 0.9)
	color.indicator.barrier = {}
	color.indicator.barrier.fill = Color.from_hsv(0.5, 1, 0.9)
	color.indicator.barrier.background = Color.from_hsv(0.5, 0.25, 0.9)
	
	color.page = {}
	color.page.rune = {}
	color.page.rune.minor = Color.from_hsv(30.0 / h, 0.8, 0.9)
	color.page.rune.major = Color.from_hsv(60.0 / h, 0.8, 0.9)
	color.page.seal = {}
	color.page.seal.minor = Color.from_hsv(120.0 / h, 0.8, 0.9)
	color.page.seal.major = Color.from_hsv(150.0 / h, 0.8, 0.9)
	color.page.ritual = {}
	color.page.ritual.minor = Color.from_hsv(180.0 / h, 0.8, 0.9)
	color.page.ritual.major = Color.from_hsv(210.0 / h, 0.8, 0.9)
	color.page.massif = {}
	color.page.massif.minor = Color.from_hsv(270.0 / h, 0.8, 0.9)
	color.page.massif.major = Color.from_hsv(300.0 / h, 0.8, 0.9)
	color.page.avatar = {}
	color.page.avatar.minor = Color.from_hsv(0.0, 0.0, 0.0)
	color.page.avatar.major = Color.from_hsv(0.0, 0.8, 0.9)
	color.page.spell = {}
	color.page.spell.minor = Color.from_hsv(120.0 / h, 0.8, 0.9)
	color.page.spell.major = Color.from_hsv(210.0 / h, 0.8, 0.9)


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var parse_err = json_object.parse(text)
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
