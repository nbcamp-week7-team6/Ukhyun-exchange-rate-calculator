import Foundation

class CalculatorViewModel: ViewModelProtocol {
    typealias Action = CalculatorViewModelAction
    typealias State = CalculatorViewModelState
    
    var action: ((Action) -> Void)?
    private(set) var state: State = .idle {
        didSet {
            action?(.stateUpdated(state))
        }
    }
    
    var currency: String?
    var country: String?
    var rate: Double?
    
    func convert(amountText: String?) {
        guard let text = amountText, !text.isEmpty else {
            action?(.showError("금액을 입력해주세요."))
            state = .error("금액을 입력해주세요.")
            return
        }
        guard let amount = Double(text) else {
            action?(.showError("올바른 숫자를 입력해주세요."))
            state = .error("올바른 숫자를 입력해주세요.")
            return
        }
        guard let rate = rate else {
            action?(.showError("환율 정보가 없습니다."))
            state = .error("환율 정보가 없습니다.")
            return
        }
        
        let result = amount * rate
        let resultString = "$\(amount.decimalFormattedWithTwo) → \(result.decimalFormattedWithTwo)\(currency ?? "")"
        state = .calculated(resultString)
    }
}
