import UIKit
import SnapKit

class ViewController: UIViewController {
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "통화 검색"
        bar.searchTextField.backgroundColor = .systemGray4
        return bar
    }()
    
    private let tableView = UITableView()
    
    private var exchangeRates: [(currency: String, rate: Double)] = []
    
    private var filteredExchangeRates: [(currency: String, rate: Double)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureUI()
    }
}

extension ViewController {
    private func configureUI() {
        setUpViews()
        setUpConstraints()
        setUpSearchBar()
        setUpTableView()
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        [searchBar, tableView].forEach { view.addSubview($0) }
    }
    
    private func setUpConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.directionalHorizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            ExchangeRateTableViewCell.self,
            forCellReuseIdentifier: ExchangeRateTableViewCell.id)
    }
}

extension ViewController {
    private func loadData() {
        NetworkManager.shared
            .callRequest(api: .usd) { (data: ExchangeRateData) in
                self.exchangeRates = data.rates.map { (code, rate) in
                    (currency: code, rate: rate)
                }
                self.filteredExchangeRates = self.exchangeRates
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } failHandler: {
                self.exchangeRates = []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.showAlert(title: "Error", message: "환율 데이터를 불러올 수 없습니다.")
                }
            }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredExchangeRates = exchangeRates
        } else {
            filteredExchangeRates = exchangeRates.filter {
                $0.currency.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredExchangeRates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeRateTableViewCell.id,
            for: indexPath
        ) as? ExchangeRateTableViewCell else {
            return ExchangeRateTableViewCell()
        }
        let item = filteredExchangeRates[indexPath.row]
        let countryName = countryMapping[item.currency] ?? "미지원 국가"
        cell
            .cellData(
                currency: item.currency,
                country: countryName,
                rate: item.rate.decimalFormatted
            )
        
        return cell
    } 
}
