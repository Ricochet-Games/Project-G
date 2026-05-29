# Place on the spellcasting UI, calculates the spells based on existing parts placed in spell menu
extends Control
@export var sigil_slot: PackedScene
var slots: Array = []


static func calculate(recipe: SpellRecipeData) -> SpellBehavior:
	var behavior = SpellBehavior.new()
	
	for sigil_entry in recipe.placed_sigils:
		var sigil: SigilData = sigil_entry["sigil"]
		var sigil_angle: float = sigil_entry["angle"]
		
		var affecting_modifiers = get_affecting_modifiers(
			recipe.placed_modifiers,
			sigil_angle
		)
		apply_sigil_with_modifiers(behavior, sigil, affecting_modifiers)
	return behavior

static func get_affecting_modifiers(modifiers: Array, sigil_angle: float) -> Array:
	var result = []
	for mod_entry in modifiers:
		var dist = angle_distance(sigil_angle, mod_entry["angle"])
		if dist <= mod_entry["modifier"].influence_radius:
			result.append(mod_entry["modifier"])
	return result

static func angle_distance(a: float, b: float) -> float:
	var diff = abs(a - b)
	return min(diff, TAU - diff)  # shortest arc between two angles

static func apply_sigil_with_modifiers(behavior: SpellBehavior, sigil: SigilData, modifiers: Array):
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
