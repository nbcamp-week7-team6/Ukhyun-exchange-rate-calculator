import Foundation

enum CalculatorViewModelState {
    case idle
    case calculated(String)
    case error(String)
}
