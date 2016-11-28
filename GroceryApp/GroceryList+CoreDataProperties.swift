//
//  GroceryList+CoreDataProperties.swift
//  GroceryApp
//
//  Created by Elh Barry on 11/27/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import Foundation
import CoreData

extension GroceryList {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryList> {
        return NSFetchRequest<GroceryList>(entityName: "List");
    }
    
    @NSManaged public var name: String?
    @NSManaged public var item: NSSet?

}

// MARK: Generated accessors for item
extension GroceryList {
    
    @objc(addItemObject:)
    @NSManaged public func addToItem(_ value: GroceryItem)
    
    @objc(removeItemObject:)
    @NSManaged public func removeFromItem(_ value: GroceryItem)
    
    @objc(addItem:)
    @NSManaged public func addToItem(_ values: NSSet)
    
    @objc(removeItem:)
    @NSManaged public func removeFromItem(_ values: NSSet)

}
