extends Control

@export var inv: Inventory 
@onready var slots: Array = $MainInventory.get_children()
@onready var extra_slots: Array = $EquipmentInventory.get_children()

@export var chest_inv: Inventory 
@onready var chest_slots: Array = $ChestInventory.get_children()



@onready var main_inventory: GridContainer = $MainInventory
@onready var chest_inventory: GridContainer = $ChestInventory
@onready var equipment_inventory: Control = $EquipmentInventory
@onready var mouse_container: Control = $MouseContainer


var is_open := false

func _ready() -> void:	 	
	
	inv.update.connect(refresh)
	refresh()
	close()
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].init(self, inv, i)
	
	for i in extra_slots.size(): 	
		extra_slots[i].init(self, inv, slots.size() + i)

func refresh() -> void:
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
	for i in extra_slots.size(): 	
		extra_slots[i].update(inv.slots[slots.size() + i])
	
	if chest_inv == null:
		return
		
	for i in chest_slots.size(): 	
		chest_slots[i].update(chest_inv.slots[i])

func _process(_delta: Variant) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open_inventory()
	
func open_inventory() -> void:
	$EquipmentInventory.show()
	$MainInventory.show()
	$ChestInventory.hide()
	visible = true
	is_open = true

func open_chest(chest_inv : Inventory) -> void:
	self.chest_inv = chest_inv
	$MainInventory.show()
	$ChestInventory.show()
	visible = true
	is_open = true
	
	for i in chest_slots.size(): 	
		chest_slots[i].init(self, chest_inv,  i)
	refresh()

func close() -> void:
	$EquipmentInventory.hide()
	$MainInventory.hide()
	$ChestInventory.hide()
	visible = false
	is_open = false
	chest_inv = null
