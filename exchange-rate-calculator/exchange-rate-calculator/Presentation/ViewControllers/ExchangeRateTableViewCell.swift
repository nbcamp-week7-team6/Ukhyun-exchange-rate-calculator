import UIKit

class ExchangeRateTableViewCell: UITableViewCell {
    static let id = "ExchangeRateTableViewCell"
    private let customContentView = ExchangeRateCellContentView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(customContentView)
        customContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellData(with data: CurrencyData) {
        customContentView.configure(with: data)
    }
}
