import UIKit

class ExchangeRateTableViewCell: UITableViewCell {
    static let id = "ExchangeRateTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.backgroundColor = .lightGray
        }
        
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
