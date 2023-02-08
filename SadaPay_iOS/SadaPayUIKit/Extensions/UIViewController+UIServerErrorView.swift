
import UIKit

extension UIViewController {
    
    static let ErrorViewTag = 100001
    
    func showError(_ title: String = "Something went wrong..",
                   message: String,
                   actionHandler: AlertAction) {
        let errorView = ServerErrorView(title: title,
                                        message: message,
                                        action: actionHandler)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.tag = Self.ErrorViewTag
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: errorView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: errorView.bottomAnchor)
        ])
    }
    
    func hideError() {
        guard let errorView = view.viewWithTag(Self.ErrorViewTag) else { return }
        errorView.removeFromSuperview()
    }
}
