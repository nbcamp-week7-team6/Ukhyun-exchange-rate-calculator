import UIKit
import SnapKit

class CalculatorView: UIView {
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "환율 계산기"
        title.font = .boldSystemFont(ofSize: 24)
        title.textAlignment = .left
        title.textColor = UIColor(named: "TextColor")
        return title
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()
    
    public let currencyLabel: UILabel = {
        let currency = UILabel()
        currency.font = .systemFont(ofSize: 24, weight: .bold)
        currency.textColor = UIColor(named: "TextColor")
        return currency
    }()
    
    public let countryLabel: UILabel = {
        let country = UILabel()
        country.font = .systemFont(ofSize: 16)
        country.textColor = UIColor(named: "SecondaryTextColor")
        return country
    }()
    
    public let amountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.placeholder = "금액을 입력하세요"
        textField.textColor = UIColor(named: "TextColor")
        textField.backgroundColor = UIColor(named: "CellBackgroundColor")
        return textField
    }()
    
    public let convertButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.setTitleColor(UIColor(named: "TextColor"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("환율 계산", for: .normal)
        return button
    }()
    
    public let resultLabel: UILabel = {
        let result = UILabel()
        result.font = .systemFont(ofSize: 20, weight: .medium)
        result.textAlignment = .center
        result.numberOfLines = 0
        result.textColor = UIColor(named: "TextColor")
        return result
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        backgroundColor = UIColor(named: "BackgroundColor")
        [titleLabel, labelStackView, amountTextField, convertButton, resultLabel].forEach { addSubview($0) }
        [currencyLabel, countryLabel].forEach { labelStackView.addArrangedSubview($0) }
    }
    
    private func setUpConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
        }
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
        }
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(32)
            make.directionalHorizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        convertButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(24)
            make.directionalHorizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(convertButton.snp.bottom).offset(32)
            make.directionalHorizontalEdges.equalToSuperview().inset(24)
        }
    }
}
