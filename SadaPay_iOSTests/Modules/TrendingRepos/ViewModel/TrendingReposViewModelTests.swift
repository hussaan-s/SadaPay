
import XCTest
import Combine
@testable import SadaPay_iOS
@testable import SadaPayKit

final class TrendingReposViewModelTests: XCTestCase {
    
    private var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        cancellable = Set<AnyCancellable>()
    }

    func test_trendingReposViewModel_cellViewModels() {
        let sut = TrendingReposViewModel(reposService: MockReposService(resultType: .repos))
        
        sut.reload()
        
        let expectation = XCTestExpectation(description: "View Model should emit cell view models")
        
        sut.cellViewModels
            .sink { models in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_trendingReposViewModel_error() {
        let sut = TrendingReposViewModel(reposService: MockReposService(resultType: .error))
        
        sut.reload()
        
        let expectation = XCTestExpectation(description: "View Model should emit error")
        
        sut.error
            .sink { models in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
    }
    
  
    func test_trendingReposViewModel_shimmeringCellViewModels() {
        let sut = TrendingReposViewModel(reposService: MockReposService(resultType: .repos))
        
        sut.reload()
        
        let expectation = XCTestExpectation(description: "View Model should emit Shimmering Cells")
        
        sut.cellViewModels
            .sink { models in
                XCTAssertTrue(models.count == 11)
                XCTAssertTrue(models.first is TrendingRepoShimmeringTVCellViewModel)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_trendingReposViewModel_repoCells() {
        let sut = TrendingReposViewModel(reposService: MockReposService(resultType: .repos))
        
        sut.reload()
        
        let expectation = XCTestExpectation(description: "View Model should emit Repos Cells")
        
        sut.cellViewModels
            .dropFirst()
            .sink { models in
                XCTAssertTrue(models.first is TrendingRepoTVCellViewModel)
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1)
    }
}
