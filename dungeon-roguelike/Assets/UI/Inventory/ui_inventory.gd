extends Control

@export var inv: Inventory 
@export var equipment_inv: Inventory 
@onready var slots: Array = $MainInventory.get_children()
@onready var extra_slots: Array = $EquipmentInventory.get_children()

@export var chest_inv: Inventory 
@onready var chest_slots: Array = $ChestInventory.get_children()



@onready var main_inventory: GridContainer = $MainInventory
@onready var chest_inventory: GridContainer = $ChestInventory
@onready var equipment_inventory: Control = $EquipmentInventory
@onready var crafting_inventory: Control = $CraftingInventory
@onready var mouse_container: Control = $MouseContainer
@onready var player: Player = $"../.."


var is_open : bool = false
var is_holding_item : bool = false
var is_hovering_item : bool = false

func _ready() -> void:	 	

	inv.update.connect(refresh)
	equipment_inv.update.connect(refresh)
	refresh()
	close()
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].init(self, inv, i)
	
	for i in extra_slots.size(): 	
		extra_slots[i].init(self, equipment_inv, i)

func refresh() -> void:
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
	for i in extra_slots.size(): 	
		extra_slots[i].update(equipment_inv.slots[i])
	
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

@warning_ignore("shadowed_variable")
func open_chest(chest_inv : Inventory) -> void:
	self.chest_inv = chest_inv
	chest_inv.update.connect(refresh)
	$MainInventory.show()
	$ChestInventory.show()
	visible = true
	is_open = true
	
	for i in chest_slots.size(): 	
		chest_slots[i].init(self, chest_inv,  i)
	refresh()

func open_crafting_table() -> void:
	$MainInventory.show()
	$CraftingInventory.show()
	visible = true
	is_open = true
	refresh()

func close() -> void:
	$EquipmentInventory.hide()
	$MainInventory.hide()
	$ChestInventory.hide()
	$CraftingInventory.hide()
	visible = false
	is_open = false
	if chest_inv:
		chest_inv.update.disconnect(refresh)
	chest_inv = null

func spawn_dropped_item(item: InventoryItem, amount: int) -> void:
	player.item_pool.spawn_item(player.global_position, item, amount)
