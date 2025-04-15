import UIKit
import SnapKit

class ViewController: UIViewController {
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureUI()
    }
}

extension ViewController{
    private func configureUI() {
        setUI()
        setHierarchy()
        setTableView()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        [tableView].forEach { view.addSubview($0) }
    }
    
    private func setHierarchy() {
        tableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func setTableView() {
        tableView.backgroundColor = .cyan
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            ExchangeRateTableViewCell.self,
            forCellReuseIdentifier: ExchangeRateTableViewCell.id)
    }
    
    private func loadData() {
        NetworkManager.shared
            .callRequest(api: .usd) { (data: ExchangeRateData) in
                print(data)
                if let krwRate = data.rates["KRW"] {
                    print("USD -> KRW : \(krwRate)")
                }
            } failHandler: {
                print("Fail")
            }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeRateTableViewCell.id,
            for: indexPath
        ) as? ExchangeRateTableViewCell else {
            return ExchangeRateTableViewCell()
        }
        
        return cell
    } 
}
