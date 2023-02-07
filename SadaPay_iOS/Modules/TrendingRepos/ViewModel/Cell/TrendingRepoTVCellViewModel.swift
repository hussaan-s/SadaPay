
import Foundation
import SadaPayKit

class TrendingRepoTVCellViewModel: ReusableViewModel {
    
    var identifier: String = TrendingRepoTVCell.identifier
    
    var ownerImageURL: URL?
    var ownerHandle: String
    var name: String
    var description: String
    var language: String?
    var starsCount: Int
    
    private let repo: Repo
    
    init(repo: Repo) {
                
        self.repo = repo
        
        ownerImageURL = repo.owner.avatarUrl
        ownerHandle = repo.owner.login
        name = repo.name
        description = repo.description
        language = repo.language
        starsCount = repo.stargazersCount
    }
}
