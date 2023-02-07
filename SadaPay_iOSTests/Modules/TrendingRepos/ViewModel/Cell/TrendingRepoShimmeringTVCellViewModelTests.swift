
import XCTest
@testable import SadaPay_iOS

final class TrendingRepoShimmeringTVCellViewModelTests: XCTestCase {

    func test_trendingRepoShimmeringTVCellViewModel_identifier() {
        
        let sut = TrendingRepoShimmeringTVCellViewModel()
        
        XCTAssertEqual(sut.identifier, TrendingRepoShimmeringTVCell.identifier)
        
    }
}
