
import XCTest
@testable import SadaPayKit

final class ReposServiceTests: XCTestCase {

    func test_reposService_fetchRepo_repos() async throws {
        let sut = ReposService(client: MockedAPIClient())
        
        let repos = try await sut.fetchRepos()
        
        XCTAssertTrue(repos.items.count > 1)
    }
}
