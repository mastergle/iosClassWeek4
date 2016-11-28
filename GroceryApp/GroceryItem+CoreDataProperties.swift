//
//  GroceryItem+CoreDataProperties.swift
//  GroceryApp
//
//  Created by Elh Barry on 11/27/16.
//  Copyright © 2016 Barry, Elh. All rights reserved.
//

import Foundation
import CoreData

extension GroceryItem {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryItem> {
        return NSFetchRequest<GroceryItem>(entityName: "Item");
    }
    
    @NSManaged public var quantity: Int16
    @NSManaged public var name: String?
    @NSManaged public var list: GroceryList?

}
