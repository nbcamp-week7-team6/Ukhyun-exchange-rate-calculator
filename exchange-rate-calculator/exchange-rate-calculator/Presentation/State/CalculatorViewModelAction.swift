import Foundation

enum CalculatorViewModelAction {
    case stateUpdated(CalculatorViewModelState)
    case showError(String)
}

