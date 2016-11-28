//
//  Item+CoreDataProperties.swift
//  GroceryApp
//
//  Created by Barry, Elh on 11/28/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var list: List?

}
