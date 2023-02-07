import Foundation
import Networking

public class BaseService {
    
    //TODO: Export baseURL for multiple schemes and versions.
    static let baseURL: String = "https://api.github.com/search/repositories?q=language=+sort:stars"
    
    private let client: APIClient
    
    public init(client: APIClient) {
        self.client = client
    }
}

extension BaseService {
    func execute<T: Decodable>(request: URLRequestConvertible) async throws -> T {
        let data = try await client.perform(request: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
 
