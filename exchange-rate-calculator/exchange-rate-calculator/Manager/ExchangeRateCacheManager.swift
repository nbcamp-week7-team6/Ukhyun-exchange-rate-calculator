import UIKit
import CoreData

// ExchangeRateCacheManager.swift
class ExchangeRateCacheManager {
    static let shared = ExchangeRateCacheManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // 신규 데이터 저장
    func save(rates: [String: Double], date: Date) {
        rates.forEach { currency, rate in
            let request: NSFetchRequest<CachedExchangeRate> = CachedExchangeRate.fetchRequest()
            request.predicate = NSPredicate(format: "currencyCode == %@ AND lastUpdated == %@", currency, date as NSDate)
            
            if let existing = try? context.fetch(request).first {
                existing.rate = rate
            } else {
                let newEntry = CachedExchangeRate(context: context)
                newEntry.currencyCode = currency
                newEntry.rate = rate
                newEntry.lastUpdated = date
            }
        }
        try? context.save()
    }
    
    // 환율 변화율 조회
    func getRateChange(currency: String) -> (current: Double, previous: Double)? {
        let request: NSFetchRequest<CachedExchangeRate> = CachedExchangeRate.fetchRequest()
        request.predicate = NSPredicate(format: "currencyCode == %@", currency)
        request.sortDescriptors = [NSSortDescriptor(key: "lastUpdated", ascending: false)]
        
        guard let results = try? context.fetch(request), results.count >= 2 else {
            return nil
        }
        
        return (current: results[0].rate, previous: results[1].rate)
    }
}
