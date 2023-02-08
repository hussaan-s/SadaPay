import Lottie
import UIKit

struct AlertAction {
    
    let title: String
    let handler: () -> Void
}

class ServerErrorView: UIView {
    
    private lazy var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "lottie-retry")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        return animationView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.text = title
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = message
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [animationView, textStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 30
        return stackView
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onTapAction), for: .touchUpInside)
        button.setTitle(action.title, for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.green.cgColor
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contentStackView, retryButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 100
        return stackView
    }()
    
    
    private let title: String
    private let message: String
    private let action: AlertAction
    
    init(title: String, message: String, action: AlertAction) {
        self.title = title
        self.message = message
        self.action = action
        super.init(frame: .zero)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupView()
        
        animationView.play()
    }
    
    @objc
    func onTapAction() {
        action.handler()
    }
    
}

extension ServerErrorView {
    
    func setupView() {
               
        backgroundColor = .systemBackground
        
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 22),
            centerYAnchor.constraint(equalTo: mainStackView.centerYAnchor)
        ])
    }
}
