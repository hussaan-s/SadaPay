
import Foundation

public protocol APIClient {
    func perform(request: URLRequestConvertible) async throws -> Data
}

enum APIClientError: Error {
    case badRequest
    case unknown
}

extension APIClientError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .badRequest, .unknown:
            return "Something went wrong"
        }
    }
}
