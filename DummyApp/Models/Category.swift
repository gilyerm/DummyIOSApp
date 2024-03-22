import Foundation

/// A collection of products categorized by their name.
struct Category: Identifiable {
    
    /// Unique identifier for each category.
    let id = UUID()
    
    /// The name of the category.
    let name: String
    
    /// The products belonging to this category.
    let products: [Product]
    
    /// The total number of products in this category.
    var totalProducts: Int {
        return products.count
    }
    
    /// The total stock quantity of all products in this category.
    var totalStock: Int {
        return products.reduce(0) { $0 + $1.stock }
    }
}
