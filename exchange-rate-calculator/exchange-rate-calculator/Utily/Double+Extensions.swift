import Foundation

extension Double {
    var decimalFormattedWithFour: String {
        return Self.formatter4.string(for: self) ?? String(self)
    }
    private static var formatter4: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 4
        return formatter
    }()
    
    var decimalFormattedWithTwo: String {
        return Self.formatter2.string(for: self) ?? String(self)
    }
    private static var formatter2: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
}
