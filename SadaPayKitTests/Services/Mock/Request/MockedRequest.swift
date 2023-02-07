
import Foundation
@testable import Networking

enum MockedRequest: String {
    case trendingRepos = "https://api.github.com/search/repositories?q=language=+sort:stars"
    case none
}

extension MockedRequest: URLRequestConvertible {

    var urlRequest: URLRequest? {
        switch self {
        case .trendingRepos:
            if let url = URL(string: self.rawValue) {
                return URLRequest(url: url)
            }
        case .none:
            break
        }
        return nil
    }
}
