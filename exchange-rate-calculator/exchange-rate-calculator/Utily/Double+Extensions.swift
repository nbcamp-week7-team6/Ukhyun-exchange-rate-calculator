import Foundation

extension Double {
    var decimalFormatted: String {
        return Self.formatter.string(for: self) ?? String(self)
    }
    private static var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        return formatter
    }()
}
