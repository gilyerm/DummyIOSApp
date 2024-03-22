import Foundation
import Combine

class CategoriesOverviewViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        isLoading = true
        
        // Check if cached data is available
        if let cachedProducts = retrieveCachedProducts() {
            // Use cached data
            updateCategories(with: cachedProducts)
            isLoading = false
            return
        }
        
        // Fetch data from network if cached data is not available
        fethDataFromAPI()
    }
    
    func fethDataFromAPI() {
        DummyAppAPIService.fetchProducts { result in
            switch result {
                case .success(let products):
                    // Save fetched data to cache
                    self.saveProductsToCache(products: products)
                    // Update categories with fetched products
                    self.updateCategories(with: products)
                case .failure(let error):
                    print("Error fetching products: \(error.localizedDescription)")
                    self.error = error
            }
            self.isLoading = false
        }
    }
    
    private func updateCategories(with products: [Product]) {
        let groupedProducts = Dictionary(grouping: products) { $0.category }
        let sortedCategoryNames = groupedProducts.keys.sorted()
        self.categories = sortedCategoryNames.map { categoryName in
            let productsForCategory = (groupedProducts[categoryName] ?? []).sorted(by: { $0.title.lowercased() < $1.title.lowercased() })
            return Category(name: categoryName, products: productsForCategory)
        }
    }
    
    private func saveProductsToCache(products: [Product]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(products) {
            UserDefaults.standard.set(encoded, forKey: "cachedProducts")
        }
    }
    
    private func retrieveCachedProducts() -> [Product]? {
        guard let cachedData = UserDefaults.standard.data(forKey: "cachedProducts") else {
            return nil
        }
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([Product].self, from: cachedData) {
            return decoded
        }
        return nil
    }
}
