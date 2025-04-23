import UIKit

class ExchangeRateTableViewCell: UITableViewCell {
    
    static let id = "ExchangeRateTableViewCell"
    
    private let customContentView = ExchangeRateCellContentView()
    
    private var currencyCode: String?
    
    var onStarTapped: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(customContentView)
        customContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        customContentView.starButton.addTarget(self, action: #selector(starTapped), for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellData(with data: CurrencyData, isFavorite: Bool) {
        currencyCode = data.currency
        customContentView.configure(with: data, isFavorite: isFavorite)
    }

    @objc private func starTapped() {
        guard let code = currencyCode else { return }
        onStarTapped?(code)
    }
}
