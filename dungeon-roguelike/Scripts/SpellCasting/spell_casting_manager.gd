# Place on the spellcasting UI, calculates the spells based on existing parts placed in spell menu
extends Control

var augment_dictionary:= preload("res://Resources/SpellCasting/AugmentResourceScripts/augment_dictionary.gd").new()

@export var augments: Array[AugmentResource] = []
@export var augment_slots: Array[Node]
var augment_names: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _get_augments() -> void:
	for augment in augment_slots:
		var spell_modifier := augment.get_node_or_null("SpellModifier")
		if spell_modifier:
			augment_names.append(spell_modifier.augment_name)

func calculate() -> Array[AugmentResource]:
	reset_values()
	_get_augments()
	for augment_name in augment_names:
		var augment_ref: AugmentResource = augment_dictionary.augments.get(augment_name, null)
		if augment_ref:
			augments.append(augment_ref.duplicate())
	return augments

func reset_values() -> void:
	augment_names.clear()
	augments.clear()
