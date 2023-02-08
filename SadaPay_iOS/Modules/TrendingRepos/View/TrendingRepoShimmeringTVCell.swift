
import UIKit

class TrendingRepoShimmeringTVCell: ConfigurableTableViewCell,
                                    ReusableView {
    
    lazy var userImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var nameView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameView, descriptionView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userImageView, userStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 30
        return stackView
    }()
    
    
    private var viewModel: TrendingRepoShimmeringTVCellViewModelType?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    override func configure(viewModel: ReusableViewModel) {
        guard let viewModel = viewModel as? TrendingRepoShimmeringTVCellViewModelType else { return }
        self.viewModel = viewModel
        
        startShimmering()
    }
}

extension TrendingRepoShimmeringTVCell {
    
    private func setupViews() {
        contentView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameView.widthAnchor.constraint(equalTo: userStackView.widthAnchor, multiplier: 0.5),
            descriptionView.widthAnchor.constraint(equalTo: userStackView.widthAnchor, multiplier: 0.9),
            
            nameView.heightAnchor.constraint(equalToConstant: 12),
            descriptionView.heightAnchor.constraint(equalToConstant: 12),
            
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            contentView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 22),
            contentView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 22),
            
        ])
    }
}

extension TrendingRepoShimmeringTVCell {
    
    func startShimmering() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = contentView.frame
        
        
        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        contentView.layer.mask = gradientLayer
        
        gradientLayer.transform = CATransform3DConcat(gradientLayer.transform, CATransform3DMakeScale(3, 3, 0))

        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 2
        animation.fromValue = -contentView.frame.width
        animation.toValue = contentView.frame.width
        animation.repeatCount = Float.infinity
        
        gradientLayer.add(animation, forKey: "GradientLayerKey")
        
    }
    
}

