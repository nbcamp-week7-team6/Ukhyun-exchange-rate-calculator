import UIKit
import SnapKit

class ViewController: UIViewController {
    private let tableView = UITableView()
    
    // 튜플 형태로 저장
    private var exchangeRates: [(currency: String, rate: Double)] = []
    
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
        setUpTableView()
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        [tableView].forEach { view.addSubview($0) }
    }
    
    private func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
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
                var rates: [(currency: String, rate: Double)] = []
                let targetCurrencies = ["KRW", "USD", "JPY"]
                for currency in targetCurrencies {
                    if let rate = data.rates[currency] {
                        rates.append((currency, rate))
                    }
                }
                self.exchangeRates = data.rates.map { (code, rate) in
                    (currency: code, rate: rate)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } failHandler: {
                self.showAlert(title: "Error", message: "환율 데이터를 불러올 수 없습니다.")
            }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeRateTableViewCell.id,
            for: indexPath
        ) as? ExchangeRateTableViewCell else {
            return ExchangeRateTableViewCell()
        }
        let item = exchangeRates[indexPath.row]
        let countryName = countryMapping[item.currency] ?? "미지원 국가"
        cell.cellData(currency: "\(item.currency) (\(countryName))", rate: item.rate.decimalFormatted)
        
        return cell
    } 
}
