//
//  DataManager.swift
//  GroceryApp
//
//  Created by Elh Barry on 11/27/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import CoreData

enum DataError: Error {
    case BadManagedObjectContext(String)
    case BadEntity(String)
}

class DataManager {
    static var shared: DataManager = DataManager()
    
    var managedObjectContext: NSManagedObjectContext?
    
    var groceryLists: [List]
    var groceryListsCount: Int {
        return groceryLists.count
    }
    
    var groceryItems: [Item]
    var groceryItemsCount: Int {
        return groceryItems.count
    }
    
    var selectedGroceryListIndex: Int
    var selectedGroceryItemIndex: Int
    
    private init() {
        groceryLists = []
        groceryItems = []
        selectedGroceryListIndex = -1
        selectedGroceryItemIndex = -1
    }
}

extension DataManager {
    func loadGroceryListData() {
        groceryLists = fetch()
    }
    
    func create(groceryListNamed name: String?) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("The managed object context was nil")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "List", in: ctx) else {
            throw DataError.BadEntity("The entity description was bad")
        }
        let obj = List(entity: entity, insertInto: ctx)
        obj.name = name
        
        try? save()
    }
    
    func deleteGroceryList(from indexPath: IndexPath) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("The managed object context was nil")
        }
        guard let list = groceryLists.value(at: indexPath.row) else {
            throw DataError.BadManagedObjectContext("The grocery list was not found")
        }
        ctx.delete(list)
        groceryLists.remove(at: indexPath.row)
        
        try? save()
    }
    
    func getGroceryListName(from indexPath: IndexPath) -> String? {
        return groceryLists.value(at: indexPath.row)?.name
    }
    
    func getGroceryList(from indexPath: IndexPath) -> (name: String?, itemCount: Int?)? {
        guard let groceryList = groceryLists.value(at: indexPath.row) else {
            return nil
        }
        
        return (groceryList.name, (groceryList.item?.count))
    }
}

extension DataManager {
    // MARK: - Get / Create New GroceryItem
    func loadGroceryItem() {
        let selectedGroceryList = groceryLists.value(at: selectedGroceryListIndex)
        groceryItems = selectedGroceryList?.item?.flatMap { item in
            return item as? Item
        } ?? []
    }
    
    func create(data: (name: String?, quantity: Int)) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("The managed object context was nil")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Item", in: ctx) else {
            throw DataError.BadEntity("The entity description was bad")
        }
        let obj = Item(entity: entity, insertInto: ctx)
        obj.name = data.name
        obj.quantity = Int16(data.quantity)
        obj.list = groceryLists.value(at: selectedGroceryListIndex)
        
        try? save()
    }
    
    func deleteGroceryItem(from indexPath: IndexPath) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("The managed object context was nil")
        }
        guard let item = groceryItems.value(at: indexPath.row) else {
            throw DataError.BadManagedObjectContext("The grocery item was not found")
        }
        ctx.delete(item)
        groceryItems.remove(at: indexPath.row)
        
        try? save()
    }
    
    func getGroceryItem(from indexPath: IndexPath) -> (name: String?, quantity: Int)? {
        guard let item = groceryItems.value(at: indexPath.row) else {
            return nil
        }
        return (item.name, Int(item.quantity))
    }
    
    func getSelectedGroceryItem() -> (name: String?, quantity: Int)? {
        guard let item = groceryItems.value(at: selectedGroceryItemIndex) else {
            return nil
        }
        return (item.name, Int(item.quantity))
    }
}

extension DataManager {
    // MARK: - Fetching Data
    
    func fetch<T: NSManagedObject>() -> [T] {
        var result: [T]? = nil
        managedObjectContext?.performAndWait { [weak self] in
            do {
                result = try self?.executeFetchRequest()
            }
            catch {
                print(error)
            }
        }
        return result ?? []
    }
    
    private func executeFetchRequest<T: NSManagedObject>() throws -> [T]? {
        let request = T.fetchRequest()
        return try request.execute() as? [T]
    }
    
    func save() throws {
        try managedObjectContext?.save()
    }
}
