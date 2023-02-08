
import XCTest
@testable import SadaPay_iOS

final class FlowControllerTests: XCTestCase {
    
    func test_flowController_uuid() {
        
        let sut = FlowController<Void>()
        
        XCTAssertNotNil(sut.uuid)
        
    }
}
