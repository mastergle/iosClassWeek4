//
//  List+CoreDataProperties.swift
//  GroceryApp
//
//  Created by Barry, Elh on 11/28/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List");
    }

    @NSManaged public var name: String?
    @NSManaged public var item: NSSet?

}

// MARK: Generated accessors for item
extension List {

    @objc(addItemObject:)
    @NSManaged public func addToItem(_ value: Item)

    @objc(removeItemObject:)
    @NSManaged public func removeFromItem(_ value: Item)

    @objc(addItem:)
    @NSManaged public func addToItem(_ values: NSSet)

    @objc(removeItem:)
    @NSManaged public func removeFromItem(_ values: NSSet)

}
