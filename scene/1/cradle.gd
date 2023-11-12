extends MarginContainer


@onready var mages = $Mages


var sketch = null


func set_attributes(input_: Dictionary) -> void:
	sketch  = input_.sketch
	
	init_mages()



func init_mages() -> void:
	for _i in 1:
		var input = {}
		input.cradle = self
	
		var mage = Global.scene.mage.instantiate()
		mages.add_child(mage)
		mage.set_attributes(input)
