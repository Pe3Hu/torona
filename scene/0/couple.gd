extends MarginContainer


@onready var title = $Title
@onready var stack = $Stack


var proprietor = null


func set_attributes(input_: Dictionary) -> void:
	proprietor = input_.proprietor
	
	stack.set_attributes(input_.stack)
	stack.custom_minimum_size = Vector2(Global.vec.size.sixteen)
	title.set_attributes(input_.title)
	title.custom_minimum_size = proprietor.custom_minimum_size - stack.custom_minimum_size * 0.75

	title.set("theme_override_constants/margin_left", 4)
	title.set("theme_override_constants/margin_top", 4)
	#custom_minimum_size = title.custom_minimum_size + stack.custom_minimum_size * 0.75

