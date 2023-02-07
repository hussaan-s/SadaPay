import XCTest
@testable import SadaPay_iOS
@testable import SadaPayKit

final class TrendingRepoTVCellViewModelTests: XCTestCase {


    func test_trendingRepoTVCellViewModel_outputs() {
        
        var sut: TrendingRepoTVCellViewModel?
        
        let repo = Repo(id: 123456789,
                        name: "Mock Repository",
                        owner: Owner(id: 123456789,
                                     login: "mock_owner",
                                     avatarUrl: nil),
                        description: "This is description of the mock repository",
                        stargazersCount: 10000,
                        language: "Urdu")
        
        sut = TrendingRepoTVCellViewModel(repo: repo)
        
        XCTAssertEqual(sut?.name, repo.name)
        XCTAssertEqual(sut?.description, repo.description)
        XCTAssertEqual(sut?.ownerHandle, repo.owner.login)
        XCTAssertEqual(sut?.ownerImageURL, repo.owner.avatarUrl)
        XCTAssertEqual(sut?.starsCount, repo.stargazersCount)
        XCTAssertEqual(sut?.language, repo.language)
        
    }
    
    
    func test_trendingRepoTVCellViewModel_identifier() {
        
        let sut = TrendingRepoTVCellViewModel(repo: Repo(id: 123456789,
                                                         name: "Mock Repository",
                                                         owner: Owner(id: 123456789,
                                                                      login: "mock_owner",
                                                                      avatarUrl: nil),
                                                         description: "This is description of the mock repository",
                                                         stargazersCount: 10000,
                                                         language: "Urdu"))
        
        XCTAssertEqual(sut.identifier, TrendingRepoTVCell.identifier)
        
    }
    
}
