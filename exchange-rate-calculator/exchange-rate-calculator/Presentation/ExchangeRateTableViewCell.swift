import UIKit
import SnapKit

class ExchangeRateTableViewCell: UITableViewCell {
    static let id = "ExchangeRateTableViewCell"
    
    private let currencyLabel: UILabel = UILabel()
    private let rateLabel: UILabel = UILabel()
    
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
        currencyLabel.text = "Test Currency"
        rateLabel.text = "Test Rate"
    }
    
    private func setUpContentViews() {
        [currencyLabel, rateLabel].forEach { contentView.addSubview($0) }
    }
    
    private func setUpCellConstraints() {
        currencyLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }

    func cellData(currency: String, rate: String) {
        currencyLabel.text = currency
        rateLabel.text = rate
    }
}
