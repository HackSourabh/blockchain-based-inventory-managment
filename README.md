# Blockchain-based Inventory Management

This repository contains a Move smart contract for Aptos blockchain that implements a decentralized inventory management system.

## Overview

The smart contract enables tracking inventory across multiple stores or warehouses on the blockchain. It provides a transparent and immutable record of inventory changes, allowing for better supply chain visibility and management.

## Features

- Initialize inventory storage for different warehouse/store owners
- Add new items to inventory with specific locations
- Update quantities of existing items
- Remove items when quantities reach zero
- Track total item count across locations

## Smart Contract Structure

### Data Structures

- **InventoryItem**: Represents a single item in inventory
  - `item_id`: String identifier for the item
  - `quantity`: Current quantity of the item
  - `location`: String identifier for the item's location

- **Inventory**: Main storage structure for each warehouse/store
  - `items`: Vector of InventoryItem objects
  - `total_items`: Total count of unique items in inventory

### Functions

1. **initialize_inventory**
   - Creates a new empty inventory for a store owner
   - Parameters: `store_owner` (signer)

2. **update_inventory**
   - Updates quantity of an item at a specific location
   - Adds new items if they don't exist
   - Removes items if quantity is set to 0
   - Parameters:
     - `store_owner` (signer)
     - `item_id` (String)
     - `location` (String)
     - `quantity` (u64)

3. **find_item** (helper function)
   - Searches for an item in inventory based on item ID and location
   - Returns a tuple: (exists: bool, index: u64)

## Usage Examples

### Initialize a new inventory

```move
// Create a new inventory for a store
public entry fun create_store_inventory(store_owner: &signer) {
    MyModule::InventoryManagement::initialize_inventory(store_owner);
}
```

### Update inventory

```move
// Add or update an item in inventory
public entry fun add_inventory_item(
    store_owner: &signer,
    item_id: String,
    location: String,
    quantity: u64
) {
    MyModule::InventoryManagement::update_inventory(store_owner, item_id, location, quantity);
}
```

## Deployment and Testing

1. Compile the contract:
```bash
aptos move compile
```

2. Test the contract:
```bash
aptos move test
```

3. Publish the contract:
```bash
aptos move publish
```

## Future Enhancements

Potential improvements for future versions:
- Add transfer functionality between locations
- Implement access control for authorized inventory managers
- Add item metadata (e.g., name, description, price)
- Integrate with supply chain tracking
- Add batch operations for inventory updates
##Contract address
"0x68ee3745fb7e4b93b3205bf729b08341a64611f2f367256892fea1c68e5ba18f"
![image](https://github.com/user-attachments/assets/0b11733c-ec95-4c99-8c8d-3a9b354b6c36)






