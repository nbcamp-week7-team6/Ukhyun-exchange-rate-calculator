import Foundation

enum ViewModelState {
    case idle
    case loaded
    case filtered
    case error(String)
}
