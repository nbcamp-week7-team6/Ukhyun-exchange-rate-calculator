import UIKit

class CalculatorViewController: UIViewController {
    private let calculatorView = CalculatorView()
    private let viewModel = CalculatorViewModel()
    
    var currency: String?
    var country: String?
    var rate: Double?
    
    override func loadView() {
        self.view = calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupButtonAction()
        loadVCData()
    }
}

extension CalculatorViewController {
    private func bindViewModel() {
        viewModel.action = { [weak self] action in
            switch action {
            case .stateUpdated(let state):
                self?.handleState(state)
            case .showError(let message):
                self?.showAlert(title: "입력 오류", message: message)
            }
        }
    }
    
    private func handleState(_ state: CalculatorViewModelState) {
        switch state {
        case .idle:
            calculatorView.resultLabel.text = ""
        case .calculated(let result):
            calculatorView.resultLabel.text = result
        case .error(let message):
            calculatorView.resultLabel.text = message
        }
    }
    
    private func setupButtonAction() {
        calculatorView.convertButton.addTarget(
            self,
            action: #selector(convertButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func loadVCData() {
        calculatorView.currencyLabel.text = currency
        calculatorView.countryLabel.text = country
        viewModel.currency = currency
        viewModel.country = country
        viewModel.rate = rate
    }
    
    @objc private func convertButtonTapped() {
        viewModel.convert(amountText: calculatorView.amountTextField.text)
    }
}
