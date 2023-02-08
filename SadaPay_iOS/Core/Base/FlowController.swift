
import Foundation
import Combine

public class FlowController<ResultType> {
    
    let uuid = UUID()
    
    var subFlowControllers: [UUID: FlowController] = [:]
    
    func store(_ flowController: FlowController) {
        subFlowControllers[flowController.uuid] = flowController
    }
    
    func free(_ flowController: FlowController) {
        subFlowControllers[flowController.uuid] = nil
    }
    
    public func start() -> AnyPublisherErrorless<ResultType> {
        fatalError("Flow controller must implement start()")
    }
    
    func navigate(to flowController: FlowController) -> AnyPublisherErrorless<ResultType> {
        return flowController.start().handleEvents(receiveOutput:  { [weak self] _ in
            self?.free(flowController)
        }).eraseToAnyPublisher()
    }
    
}
