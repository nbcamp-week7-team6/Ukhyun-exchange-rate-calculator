//
//  FavoriteCurrency+CoreDataProperties.swift
//  exchange-rate-calculator
//
//  Created by GO on 4/24/25.
//
//

import Foundation
import CoreData


extension FavoriteCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCurrency> {
        return NSFetchRequest<FavoriteCurrency>(entityName: "FavoriteCurrency")
    }

    @NSManaged public var code: String?

}

extension FavoriteCurrency : Identifiable {

}
