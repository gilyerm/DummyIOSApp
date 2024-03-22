import Foundation

/// A struct representing a product.
struct Product: Codable {
    
    /// The unique identifier for the product.
    let id: Int
    
    /// The title of the product.
    let title: String
    
    /// The price of the product.
    let price: Double
    
    /// The stock quantity of the product.
    let stock: Int
    
    /// The category of the product.
    let category: String
    
    /// The URL of the thumbnail image for the product.
    let thumbnail: String
}

/// A struct representing a response containing a list of products.
struct ProductResponse: Decodable {
    
    /// The array of products.
    let products: [Product]
    
    /// The total number of products in the response.
    let total: Int
    
    /// The number of products skipped in the response.
    let skip: Int
    
    /// The maximum number of products requested in the response.
    let limit: Int
}
