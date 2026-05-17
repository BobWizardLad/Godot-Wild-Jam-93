class_name UpgradeLabel
extends HBoxContainer

@onready var title: Label = $HBoxContainer/Title
@onready var effect_desc: Label = $HBoxContainer/Effect
@onready var value_label: Label = $Value

var title_text : String
var effect_text : String
var value_text : String

func _ready() -> void:
	fufill_label()

func fufill_label() -> void:
	title.text = title_text
	effect_desc.text = effect_text
	value_label.text = value_text

# Instantiate with title, flavortext, and upgrade value
func set_label_data(my_title: String, my_effect_desc: String, my_value: String) -> void:
	title_text = my_title
	effect_text = my_effect_desc
	value_text = my_value
