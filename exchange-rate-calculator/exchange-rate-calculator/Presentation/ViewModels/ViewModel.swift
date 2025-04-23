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
    
    // MARK: - Properties
    var action: ((Action) -> Void)?
    private(set) var state: State = .idle {
        didSet { action?(.stateUpdated(state)) }
    }
    
    private var exchangeRates: [(currency: String, rate: Double)] = []
    private let currencyCountry = countryMapping
    private let favoriteManager = FavoriteCurrencyManager.shared
    
    // MARK: - Data Management
    private var favoriteCodes: [String] = []
    private var filteredExchangeRates: [(currency: String, rate: Double)] = []
    
    // 정렬된 데이터 (즐겨찾기 우선 + 알파벳순)
    private var sortedFilteredItems: [(currency: String, rate: Double)] {
        let favorites = filteredExchangeRates.filter { favoriteCodes.contains($0.currency) }.sorted { $0.currency < $1.currency }
        let nonFavorites = filteredExchangeRates.filter { !favoriteCodes.contains($0.currency) }.sorted { $0.currency < $1.currency }
        return favorites + nonFavorites
    }
    
    // MARK: - Public Properties
    var shouldShowEmptyState: Bool {
        sortedFilteredItems.isEmpty
    }
    
    var filteredCount: Int {
        sortedFilteredItems.count
    }
    
    // MARK: - CoreData Methods
    func isFavorite(currency: String) -> Bool {
        favoriteCodes.contains(currency)
    }
    
    func toggleFavorite(currency: String) {
        if isFavorite(currency: currency) {
            favoriteManager.removeFavorite(code: currency)
        } else {
            favoriteManager.addFavorite(code: currency)
        }
        favoriteCodes = favoriteManager.fetchFavorites()
        state = .filtered // UI 갱신 트리거
    }
    
    // MARK: - Data Methods
    func getFilteredItem(at index: Int) -> (currency: String, rate: Double)? {
        guard sortedFilteredItems.indices.contains(index) else { return nil }
        return sortedFilteredItems[index]
    }
    
    func getCountryName(for currency: String) -> String {
        currencyCountry[currency] ?? "알 수 없는 국가"
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
            rate: item.rate
        )
    }
    
    func loadData() {
        NetworkManager.shared.callRequest(api: .usd) { [weak self] (data: ExchangeRateData) in
            self?.exchangeRates = data.rates.map { ($0.key, $0.value) }
            self?.filteredExchangeRates = self?.exchangeRates ?? []
            self?.favoriteCodes = self?.favoriteManager.fetchFavorites() ?? []
            self?.state = .loaded
        } failHandler: { [weak self] in
            self?.state = .error("환율 데이터를 불러올 수 없습니다.")
        }
    }
}
