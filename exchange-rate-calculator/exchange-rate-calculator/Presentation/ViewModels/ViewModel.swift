import Foundation

protocol ViewModelProtocol {
    associatedtype Action
    associatedtype State
    
    var action: ((Action) -> Void)? { get }
    var state: State { get }
}

class ViewModel: ViewModelProtocol {
    typealias Action = ViewModelAction
    typealias State = ViewModelState
    
    var action: ((Action) -> Void)?
    private(set) var state: State = .idle {
        didSet { action?(.stateUpdated(state)) }
    }
    
    private var exchangeRates: [(currency: String, rate: Double)] = []
    private var filteredExchangeRates: [(currency: String, rate: Double)] = []
    private let currencyCountry = countryMapping
    
}

extension ViewModel {
    var shouldShowEmptyState: Bool {
        filteredExchangeRates.isEmpty
    }
    
    var filteredCount: Int {
        filteredExchangeRates.count
    }
    
    func getFilteredItem(at index: Int) -> (currency: String, rate: Double)? {
        guard filteredExchangeRates.indices.contains(index) else { return nil }
        return filteredExchangeRates[index]
    }
    
    func getCountryName(for currency: String) -> String {
        currencyCountry[currency] ?? "미지원 국가"
    }
    
    func searchCurrency(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        filteredExchangeRates = trimmed.isEmpty
        ? exchangeRates
        : exchangeRates.filter {
            $0.currency.lowercased().contains(trimmed) ||
            (currencyCountry[$0.currency]?.lowercased() ?? "").contains(trimmed)
        }
        state = .filtered
    }
    
    func getSelectedCurrencyData(at index: Int) -> CurrencyData? {
        guard let item = getFilteredItem(at: index) else { return nil }
        return CurrencyData(
            currency: item.currency,
            country: getCountryName(for: item.currency),
            rate: item.rate)
    }
    
    func loadData() {
        NetworkManager.shared.callRequest(api: .usd) { [weak self] (data: ExchangeRateData) in
            self?.exchangeRates = data.rates.map { ($0.key, $0.value) }
            self?.filteredExchangeRates = self?.exchangeRates ?? []
            self?.state = .loaded
        } failHandler: { [weak self] in
            self?.state = .error("환율 데이터를 불러올 수 없습니다.")
        }
    }
}
