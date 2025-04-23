import UIKit
import SnapKit

class ExchangeRateCellContentView: UIView {
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "TextColor")
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "SecondaryTextColor")
        return label
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = UIColor(named: "TextColor")
        return label
    }()
    
    let starButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(named: "FavoriteColor")
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpContentViews()
        setUpConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpContentViews() {
        backgroundColor = UIColor(named: "CellBackgroundColor")
        [labelStackView, rateLabel, starButton].forEach { addSubview($0) }
        [currencyLabel, countryLabel].forEach { labelStackView.addArrangedSubview($0) }
    }
    
    private func setUpConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        rateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(starButton.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(labelStackView.snp.trailing).offset(16)
            make.width.equalTo(100)
        }
        
        starButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(28)
        }
    }
    
    func configure(with data: CurrencyData, isFavorite: Bool) {
        currencyLabel.text = data.currency
        countryLabel.text = data.country
        rateLabel.text = "\(data.rate.decimalFormattedWithFour)"
        let imageName = isFavorite ? "star.fill" : "star"
        starButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
