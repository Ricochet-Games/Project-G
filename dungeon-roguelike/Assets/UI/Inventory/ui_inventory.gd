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

enum InventoryState
{
	CRAFTING,
	CHEST,
	MAIN,
	CLOSED,
}

var inventory_state : InventoryState = InventoryState.CLOSED

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
	if Input.is_action_just_pressed("test_input"):
		fast_deposit()
	
func open_inventory() -> void:
	$EquipmentInventory.show()
	$MainInventory.show()
	$ChestInventory.hide()
	visible = true
	is_open = true
	inventory_state = InventoryState.MAIN
	refresh()

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
	inventory_state = InventoryState.CHEST
	refresh()

func open_crafting_table() -> void:
	$MainInventory.show()
	$CraftingInventory.show()
	visible = true
	is_open = true
	inventory_state = InventoryState.CRAFTING
	refresh()

func close() -> void:
	
	if is_holding_item:
		var max_to_add : int = inv.get_maxium_to_add(mouse_container.item)
		
		var to_add: int = mini(mouse_container.amount, max_to_add)
		var remainder: int = mouse_container.amount - to_add
	
		if to_add > 0:
			inv.insert(mouse_container.item, to_add)

		if remainder > 0:
			spawn_dropped_item(mouse_container.item, remainder)
	
		mouse_container.clear()
		is_holding_item = false
	
	
	$EquipmentInventory.hide()
	$MainInventory.hide()
	$ChestInventory.hide()
	$CraftingInventory.hide()
	visible = false
	is_open = false
	if chest_inv:
		chest_inv.update.disconnect(refresh)
	chest_inv = null
	inventory_state = InventoryState.CLOSED

func spawn_dropped_item(item: InventoryItem, amount: int) -> void:
	player.item_pool.spawn_item(player.global_position, item, amount)
	
func find_typed_slot(type: EquipmentData.EquipmentType) -> EquipmentSlotUI:
	for slot : InventorySlotUI in extra_slots:
		if slot.equipment_type == type:
			return slot
	return null
	
func fast_deposit() -> void:
	# Needs a from inventory and a to inventory
	# this can lowkey be hard coded when we set up the UI buttoms for this
	var slot_index : int = 0
	for slot in inv.slots:
		if slot.item == null:
			slot_index += 1
			continue
		
		var max_to_add : int = chest_inv.get_maxium_to_add(slot.item)
		
		var to_add: int = mini(slot.amount, max_to_add)
		#var remainder: int = slot.amount - to_add
	
		if to_add > 0:
			chest_inv.insert(slot.item, to_add)
			inv.remove_item_from_slot(slot_index, to_add)
		
		slot_index += 1
