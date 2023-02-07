
import Foundation

public protocol ReposServiceType {
    func fetchRepos() async throws -> Repos
}

public class ReposService: BaseService,
                           ReposServiceType {
    
    public func fetchRepos() async throws -> Repos {
        let request = Request(base: Self.baseURL)
        return try await execute(request: request)
    }
}
