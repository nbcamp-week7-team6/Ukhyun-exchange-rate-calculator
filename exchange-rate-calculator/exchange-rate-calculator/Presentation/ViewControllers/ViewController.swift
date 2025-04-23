import UIKit
import SnapKit

class ViewController: UIViewController {
    private let mainView = MainView()
    private let viewModel = ViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupTableView()
        setupSearchBar()
        viewModel.loadData()
    }
    
    private func bindViewModel() {
        viewModel.action = { [weak self] action in
            DispatchQueue.main.async {
                switch action {
                case .stateUpdated(let state):
                    self?.handleState(state)
                case .showError(let message):
                    self?.showAlert(title: "Error", message: message)
                }
            }
        }
    }
    
    private func handleState(_ state: ViewModelState) {
        switch state {
        case .loaded, .filtered:
            mainView.tableView.reloadData()
        case .error(let message):
            self.showAlert(title: "Error", message: message)
        case .idle:
            break
        }
    }
    
    private func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(
            ExchangeRateTableViewCell.self,
            forCellReuseIdentifier: ExchangeRateTableViewCell.id
        )
    }
    
    private func setupSearchBar() {
        mainView.searchBar.delegate = self
    }
}

// MARK: - SearchBar Delegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCurrency(searchText)
    }
}

// MARK: - TableView DataSource & Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shouldShowEmptyState ? 1 : viewModel.filteredCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.shouldShowEmptyState {
            let cell = UITableViewCell()
            var config = cell.defaultContentConfiguration()
            config.text = "검색 결과가 없습니다."
            config.textProperties.alignment = .center
            cell.contentConfiguration = config
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExchangeRateTableViewCell.id,
            for: indexPath
        ) as? ExchangeRateTableViewCell,
        let item = viewModel.getFilteredItem(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let countryName = viewModel.getCountryName(for: item.currency)
        let data = CurrencyData(currency: item.currency, country: countryName, rate: item.rate)
        let isFavorite = viewModel.isFavorite(currency: item.currency)
        
        cell.cellData(with: data, isFavorite: isFavorite)
        cell.onStarTapped = { [weak self] code in
            self?.viewModel.toggleFavorite(currency: code)
            self?.mainView.tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel.getSelectedCurrencyData(at: indexPath.row) else { return }
        let calcVC = CalculatorViewController()
        calcVC.currency = data.currency
        calcVC.country = data.country
        calcVC.rate = data.rate
        
        navigationController?.pushViewController(calcVC, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "환율 정보",
            style: .plain,
            target: nil,
            action: nil
        )
    }
}
