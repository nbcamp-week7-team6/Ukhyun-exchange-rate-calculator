import UIKit
import CoreData

class FavoriteCurrencyManager {
    static let shared = FavoriteCurrencyManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func isFavorite(code: String) -> Bool {
        let request: NSFetchRequest<FavoriteCurrency> = FavoriteCurrency.fetchRequest()
        request.predicate = NSPredicate(format: "code == %@", code)
        return (try? context.count(for: request)) ?? 0 > 0
    }

    func addFavorite(code: String) {
        guard !isFavorite(code: code) else { return }
        let favorite = FavoriteCurrency(context: context)
        favorite.code = code
        try? context.save()
    }

    func removeFavorite(code: String) {
        let request: NSFetchRequest<FavoriteCurrency> = FavoriteCurrency.fetchRequest()
        request.predicate = NSPredicate(format: "code == %@", code)
        if let result = try? context.fetch(request), let objectToDelete = result.first {
            context.delete(objectToDelete)
            try? context.save()
        }
    }

    func fetchFavorites() -> [String] {
        let request: NSFetchRequest<FavoriteCurrency> = FavoriteCurrency.fetchRequest()
        let result = (try? context.fetch(request)) ?? []
        return result.compactMap { $0.code }
    }
}
