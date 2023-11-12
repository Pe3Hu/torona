extends MarginContainer


@onready var bg = $BG

var grimoire = null
var recipe = null
var type = null
var subtype = null


func set_attributes(input_: Dictionary) -> void:
	grimoire  = input_.grimoire
	type  = input_.type
	subtype  = input_.subtype
	
	if type == "avatar" and subtype == "minor":
		bg.visible = false
	
	var style = StyleBoxFlat.new()
	bg.set("theme_override_styles/panel", style)
	style.bg_color = Global.color.page[type][subtype]
	custom_minimum_size = Vector2(Global.vec.size.page)


func set_recipe(recipe_: MarginContainer) -> void:
	pass
