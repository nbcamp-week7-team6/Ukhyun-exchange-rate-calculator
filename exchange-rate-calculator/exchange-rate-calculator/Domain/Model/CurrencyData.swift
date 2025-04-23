import Foundation

struct CurrencyData {
    let currency: String
    let country: String
    let rate: Double
    
    init(currency: String, country: String, rate: Double) {
        self.currency = currency
        self.country = country
        self.rate = rate
    }
}
