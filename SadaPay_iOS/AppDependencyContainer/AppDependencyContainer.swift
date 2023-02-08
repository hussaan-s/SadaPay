import Foundation
import SadaPayKit
import Networking
import UIKit


public class AppDependencyContainer {
    
    let reposService: ReposServiceType
    let apiClient: APIClient
    
    public init() {
        apiClient = WebClient()
        
        reposService = ReposService(client: apiClient)
    }
    
    public func makeTrendingReposFlowController(window: UIWindow) -> FlowController<Void> {
        return AppFlowController(window: window,
                                 factory: self)
    }
    
    func makeTrendingReposViewModel() -> TrendingReposViewModelType {
        TrendingReposViewModel(reposService: reposService)
    }
    
    func makeTrendingReposViewController(viewModel: TrendingReposViewModelType) -> UIViewController {
        TrendingReposViewController(viewModel: viewModel)
    }
}

