import UIKit
import SnapKit

class ExchangeRateTableViewCell: UITableViewCell {
    static let id = "ExchangeRateTableViewCell"
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private let currencyLabel: UILabel = {
        let currency = UILabel()
        currency.font = .systemFont(ofSize: 16, weight: .medium)
        return currency
    }()
    
    private let countryLabel: UILabel = {
        let country = UILabel()
        country.font = .systemFont(ofSize: 14)
        country.textColor = .lightGray
        return country
    }()
    
    private let rateLabel: UILabel = {
        let rate = UILabel()
        rate.font = .systemFont(ofSize: 16)
        rate.textAlignment = .right
        return rate
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExchangeRateTableViewCell {
    private func configureUI() {
        setUpContentViews()
        setUpCellConstraints()
    }
    
    private func setUpContentViews() {
        [labelStackView, rateLabel].forEach { contentView.addSubview($0) }
        [currencyLabel, countryLabel].forEach { labelStackView.addArrangedSubview($0) }
    }
    
    private func setUpCellConstraints() {
        labelStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        rateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(labelStackView.snp.trailing).offset(16)
            make.width.equalTo(120)
        }
    }
    
    func cellData(currency: String, country: String, rate: String) {
        currencyLabel.text = currency
        countryLabel.text = country
        rateLabel.text = rate
    }
}
