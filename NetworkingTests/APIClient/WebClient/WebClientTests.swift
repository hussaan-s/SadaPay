
import XCTest
@testable import Networking

final class WebClientTests: XCTestCase {

    func test_webClient_performRequest_success() async throws {
        let sut = WebClient(session: URLSession(configuration: .default))
        
        struct TestRequest: URLRequestConvertible {
            let url = URL(string: "https://api.github.com/search/repositories?q=language=")
            
            var urlRequest: URLRequest? {
                guard let url = url else { return nil }
                return URLRequest(url: url)
            }
        }
        
        let data = try await sut.perform(request: TestRequest())
        
        XCTAssert(data.count > 0)
    }
    
    func test_webClient_performRequest_failed() {
        let sut = WebClient(session: URLSession(configuration: .default))
        
        struct TestRequest: URLRequestConvertible {
            let url = URL(string: "http://www.sadapay.pk")
            
            var urlRequest: URLRequest? {
                guard let url = url else { return nil }
                return URLRequest(url: url)
            }
        }
        let expectation = XCTestExpectation(description: "Should get an error")
        Task {
            do {
                let _ = try await sut.perform(request: TestRequest())
            } catch {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
       
    }

}
