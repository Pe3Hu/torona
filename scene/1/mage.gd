extends MarginContainer


@onready var grimoire = $HBox/Grimoire
@onready var сarton = $HBox/Carton


var cradle = null


func set_attributes(input_: Dictionary) -> void:
	cradle  = input_.cradle
	
	var input = {}
	input.mage = self
	grimoire.set_attributes(input)
	сarton.set_attributes(input)
