
import XCTest
@testable import SadaPayKit

final class RequestTests: XCTestCase {

    func test_request_urlRequest() {
        
        let sut = Request(base: "http://www.sadapay.pk")
        
        let request = sut.urlRequest
        
        XCTAssert(request != nil)
        
    }
}
