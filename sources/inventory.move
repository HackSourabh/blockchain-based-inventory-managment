module MyModule::InventoryManagement {
    use std::string::{String};
    use std::vector;
    use aptos_framework::signer;
    
    /// Struct representing an item in inventory
    struct InventoryItem has store, drop {
        item_id: String,
        quantity: u64,
        location: String,
    }
    
    /// Main inventory storage for each warehouse/store
    struct Inventory has key {
        items: vector<InventoryItem>,
        total_items: u64,
    }
    
    /// Initialize a new inventory for a store/warehouse
    public fun initialize_inventory(store_owner: &signer) {
        let inventory = Inventory {
            items: vector::empty<InventoryItem>(),
            total_items: 0,
        };
        move_to(store_owner, inventory);
    }
    
    /// Update inventory for a specific item
    /// If item doesn't exist, it will be added
    /// If quantity is 0, item will be removed
    public fun update_inventory(
        store_owner: &signer,
        item_id: String,
        location: String,
        quantity: u64
    ) acquires Inventory {
        let store_addr = signer::address_of(store_owner);
        let inventory = borrow_global_mut<Inventory>(store_addr);
        
        let (exists, index) = find_item(&inventory.items, &item_id, &location);
        
        if (exists) {
            if (quantity > 0) {
                vector::borrow_mut(&mut inventory.items, index).quantity = quantity;
            } else {
                vector::remove(&mut inventory.items, index);
                inventory.total_items = inventory.total_items - 1;
            }
        } else if (quantity > 0) {
            // Add new item
            vector::push_back(&mut inventory.items, InventoryItem {
                item_id,
                quantity,
                location,
            });
            inventory.total_items = inventory.total_items + 1;
        }
    }
    
    /// Helper function to find an item in inventory
    fun find_item(items: &vector<InventoryItem>, item_id: &String, location: &String): (bool, u64) {
        let i = 0;
        let len = vector::length(items);
        
        while (i < len) {
            let item = vector::borrow(items, i);
            if (item.item_id == *item_id && item.location == *location) {
                return (true, i)
            };
            i = i + 1;
        };
        
        (false, 0)
    }
}
