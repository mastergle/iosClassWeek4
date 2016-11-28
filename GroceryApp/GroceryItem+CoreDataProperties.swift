//
//  Item+CoreDataProperties.swift
//  GroceryApp
//
//  Created by Barry, Elh on 11/28/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension GroceryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryItem> {
        return NSFetchRequest<GroceryItem>(entityName: "Item");
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var list: GroceryList?

}
