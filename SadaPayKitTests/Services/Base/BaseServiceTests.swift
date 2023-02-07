
import XCTest
@testable import SadaPayKit

final class BaseServiceTests: XCTestCase {
    
    func test_baseService_executeRequest_success() async throws {
        
        let sut = BaseService(client: MockedAPIClient())

        let _: Repos = try await sut.execute(request: MockedRequest.trendingRepos)
        
        XCTAssertTrue(true)
    }
    
    
    func test_baseService_executeRequest_failure() {
        
        let sut = BaseService(client: MockedAPIClient())

        let expectation = XCTestExpectation(description: "Fail to execute request")
        
        Task {
            do {
                let _: String = try await sut.execute(request: MockedRequest.none)
            } catch {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)
    }
    
}
