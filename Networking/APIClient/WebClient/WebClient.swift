
import Foundation

public class WebClient: APIClient {
    
    private let session: URLSession
    
    public init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    public func perform(request: URLRequestConvertible) async throws -> Data {
        
        try await withCheckedThrowingContinuation({ continuation in
            guard let urlRequest = request.urlRequest else {
                continuation.resume(throwing: APIClientError.badRequest)
                return
            }
            
            session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data,
                          let response = response as? HTTPURLResponse,
                          response.statusCode == 200 {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(throwing: APIClientError.unknown)
                }
            }.resume()
        })
    }
}
