extends MarginContainer

@onready var roll = $Boxs/Roll
@onready var reserve = $Boxs/Reserve

var mage = null
var chain = {}
var indexs = {}
var symbols = {}


func set_attributes(input_: Dictionary) -> void:
	mage = input_.mage

	chain["Roll"] = "reserve"
	chain["Reserve"] = "roll"
	
	for key in chain:
		var name_ = chain[key]
		var box = get(name_)
		box.title.text = name_
	
	init_dices()
	reroll_dices()


func init_dices() -> void:
	for _i in 5:
		var input = {}
		input.carton = self
		input.box = roll
	
		var dice = Global.scene.dice.instantiate()
		roll.dices.add_child(dice)
		dice.set_attributes(input)


func push_dice_in_next_box(dice_) -> void:
	var next_box = get(chain[dice_.box.name])
	dice_.box.dices.remove_child(dice_)
	#dice_.box.update_dices_columns()
	next_box.dices.add_child(dice_)
	dice_.box = next_box
	#next_box.update_dices_columns()


func reroll_dices() -> void:
	for dice in roll.dices.get_children():
		dice.skip_animation()
	
	update_indexs()


func active_dices() -> void:
	#get_detect_kits()
	
	for dice in reserve.dices.get_children():
		push_dice_in_next_box(dice)


func discard_dices() -> void:
	for dice in roll.dices.get_children():
		push_dice_in_next_box(dice)


func update_indexs() -> void:
	indexs = {}
	symbols = {}
	
	for key in chain:
		var name_ = chain[key]
		var box = get(name_)
		
		for dice in box.dices.get_children():
			var index = dice.get_current_facet_index()
			
			if !indexs.has(index):
				indexs[index] = 0
			
			indexs[index] += 1
			var symbol = Global.arr.symbol[index-1]
			
			if !symbols.has(symbol):
				symbols[symbol] = 0
				
			symbols[symbol] += 1
	
	print(symbols)
	check_all_kits()


func check_all_kits() -> void:
	for index in Global.dict.kit.index:
		var description = Global.dict.kit.index[index]
		
		if !description.symbols.keys().is_empty():
			if check_kit_symbols(description.symbols):
				print(description)


func check_kit_symbols(symbols_: Dictionary) -> bool:
	for symbol in symbols_:
		if symbols.has(symbol):
			if symbols_[symbol] > symbols[symbol]:
				return false
		else:
			return false
	
	return true

