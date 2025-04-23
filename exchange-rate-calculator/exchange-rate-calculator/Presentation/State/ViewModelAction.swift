import Foundation

enum ViewModelAction {
    case stateUpdated(ViewModelState)
    case showError(String)
}
