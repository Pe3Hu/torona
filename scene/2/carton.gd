extends MarginContainer

@onready var roll = $Boxs/Roll
@onready var reserve = $Boxs/Reserve

var mage = null
var chain = {}


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


func active_dices() -> void:
	#get_detect_kits()
	
	for dice in reserve.dices.get_children():
		push_dice_in_next_box(dice)


func discard_dices() -> void:
	for dice in roll.dices.get_children():
		push_dice_in_next_box(dice)


#func all_in_one() -> void:
#	for dice in preparation.dices.get_children():
#		dice.skip_animation()
#		push_dice_in_next_box(dice)
#
#	active_dices()


