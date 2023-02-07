
import Foundation
@testable import SadaPayKit

enum MockReposServiceOutput {
    case repos
    case error
}

enum MockReposServiceError: Error {
    case error
}

class MockReposService: ReposServiceType {
    
    private let resultType: MockReposServiceOutput
    
    init(resultType: MockReposServiceOutput) {
        self.resultType = resultType
    }
    
    func fetchRepos() async throws -> Repos {
        
        switch resultType {
        case .repos:
            return Repos(items: [
                Repo(id: 123456789,
                     name: "Mock Repository",
                     owner: Owner(id: 123456789,
                                  login: "mock_owner",
                                  avatarUrl: nil),
                     description: "This is description of the mock repository",
                     stargazersCount: 10000,
                     language: "Urdu")
            ])
        case .error:
            throw MockReposServiceError.error
        }
        
        
    }
}
 
