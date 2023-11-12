extends MarginContainer


@onready var pages = $Pages


var mage = null


func set_attributes(input_: Dictionary) -> void:
	mage  = input_.mage
	
	init_pages()



func init_pages() -> void:
	var orders = []
	orders.append_array(Global.dict.kit.order.keys())
	orders.sort()
	
	for order in orders:
		var index = Global.dict.kit.order[order]
		#print([order, index])
		var input = {}
		input.grimoire = self
		input.type = Global.dict.kit.index[index].type
		input.subtype = Global.dict.kit.index[index].subtype
	
		var page = Global.scene.page.instantiate()
		pages.add_child(page)
		page.set_attributes(input)
