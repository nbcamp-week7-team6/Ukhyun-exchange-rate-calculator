import UIKit
import SnapKit

class MainView: UIView {
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "통화 검색"
        bar.searchTextField.backgroundColor = UIColor(named: "CellBackgroundColor")
        return bar
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = UIColor(named: "BackgroundColor")
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = UIColor(named: "BackgroundColor")
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
