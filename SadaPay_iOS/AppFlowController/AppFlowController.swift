
import Foundation
import Combine
import UIKit

public class AppFlowController: FlowController<Void> {
    
    private let result = PassthroughValueSubjectErrorless<Void>()
    private let window: UIWindow
    private let factory: AppFlowControllerFactory
    private var navigationController: UINavigationController?

    init(window: UIWindow,
         factory: AppFlowControllerFactory) {
        self.window = window
        self.factory = factory
    }
    
    public override func start() -> AnyPublisherErrorless<Void> {
        
        let viewModel = factory.makeTrendingReposViewModel()
        let viewController = factory.makeTrendingReposViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return result.eraseToAnyPublisher()
    }

}


protocol AppFlowControllerFactory {
    func makeTrendingReposViewModel() -> TrendingReposViewModelType
    func makeTrendingReposViewController(viewModel: TrendingReposViewModelType) -> UIViewController
}

extension AppDependencyContainer: AppFlowControllerFactory { }
