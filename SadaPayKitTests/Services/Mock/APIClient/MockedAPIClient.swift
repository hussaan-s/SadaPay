
import Foundation
@testable import Networking

class MockedAPIClient: APIClient {
    func perform(request: URLRequestConvertible) async throws -> Data {
        
        guard let urlString = request.urlRequest?.url?.absoluteString else {
            throw APIClientError.unknown
        }
        
        let request = MockedRequest(rawValue: urlString)
        
        switch  request {
        case .trendingRepos:
            return MockedTrendingReposResponse.trendingReposJSONData
        default:
            break
        }
        
        return Data()
        
    }
}
