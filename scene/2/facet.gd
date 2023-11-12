extends MarginContainer


@onready var couple = $Couple

var dice = null
var index = null
var token = null


func set_attributes(input_: Dictionary) -> void:
	dice = input_.dice
	index = input_.index
	token = Global.arr.token[index-1]
	
	custom_minimum_size = Vector2(Global.vec.size.facet)
	var input = {}
	input.proprietor = self
	input.title = {}
	input.title.type = "token"
	input.title.subtype = token
	input.stack = {}
	input.stack.type = "number"
	input.stack.subtype = index
	couple.set_attributes(input)
