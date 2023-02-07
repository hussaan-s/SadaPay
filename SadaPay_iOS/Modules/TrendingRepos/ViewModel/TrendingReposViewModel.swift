
import Foundation
import Combine
import SadaPayKit

protocol TrendingReposViewModelType {
    //Outputs
    var cellViewModels: AnyPublisherErrorless<[ReusableViewModel]> { get }
    var error: AnyPublisherErrorless<String> { get }
    
    //Inputs
    func reload()
}

class TrendingReposViewModel: TrendingReposViewModelType {
    
    var cellViewModels: AnyPublisherErrorless<[ReusableViewModel]> {
        cellViewModelsSubject.eraseToAnyPublisher()
    }
    
    var error: AnyPublisherErrorless<String> {
        errorSubject.eraseToAnyPublisher()
    }
    
    private var cellViewModelsSubject = CurrentValueSubjectErrorless<[ReusableViewModel]>([])
    private var errorSubject = PassthroughValueSubjectErrorless<String>()
    
    private let reposService: ReposServiceType
    
    init(reposService: ReposServiceType) {
        self.reposService = reposService
    }
    
    func reload() {
        
        if cellViewModelsSubject.value.count < 1 {
            cellViewModelsSubject.send((0..<11).map { _ in TrendingRepoShimmeringTVCellViewModel() })
        }
        
        Task {
            do {
                let repos =  try await reposService.fetchRepos()
                await MainActor.run {
                    cellViewModelsSubject.send(repos.items.map { TrendingRepoTVCellViewModel(repo:$0) })
                }
            } catch {
                await MainActor.run {
                    errorSubject.send(error.localizedDescription)
                }
            }
        }
    }
}
