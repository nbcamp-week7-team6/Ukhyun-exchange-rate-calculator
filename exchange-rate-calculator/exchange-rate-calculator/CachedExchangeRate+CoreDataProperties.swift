//
//  CachedExchangeRate+CoreDataProperties.swift
//  exchange-rate-calculator
//
//  Created by GO on 4/24/25.
//
//

import Foundation
import CoreData


extension CachedExchangeRate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedExchangeRate> {
        return NSFetchRequest<CachedExchangeRate>(entityName: "CachedExchangeRate")
    }

    @NSManaged public var currencyCode: String?
    @NSManaged public var rate: Double
    @NSManaged public var lastUpdated: Date?

}

extension CachedExchangeRate : Identifiable {

}
