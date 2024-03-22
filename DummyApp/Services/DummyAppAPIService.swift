import Foundation
import Combine

struct DummyAppAPIService {
    static func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let urlString = "https://dummyjson.com/products?limit=100&select=id,title,price,stock,thumbnail,category"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidStatusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noDataReceived))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ProductResponse.self, from: data)
                completion(.success(response.products))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noDataReceived
    case invalidResponse
    case invalidStatusCode(Int)
}
