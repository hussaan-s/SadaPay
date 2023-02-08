
import UIKit
import Kingfisher

class TrendingRepoTVCell: ConfigurableTableViewCell,
                          ReusableView {
    
    lazy var ownerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var ownerHandleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    lazy var repoTitleLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    lazy var repoDescriptionLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.numberOfLines = 5
        return label
    }()
    
    lazy var repoLanguageLabel: UILeadingImageLabel = {
        let label = UILeadingImageLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    lazy var repoStarsLabel: UILeadingImageLabel = {
        let label = UILeadingImageLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    
    lazy var languageStarStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [repoLanguageLabel, repoStarsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ownerHandleLabel, repoTitleLabel, repoDescriptionLabel, languageStarStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ownerImageView, textStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 30
        return stackView
    }()
    
    private var viewModel: TrendingRepoTVCellViewModelType?
    
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
        guard let viewModel = viewModel as? TrendingRepoTVCellViewModelType else {
            return
        }
        
        self.viewModel = viewModel
        
        ownerImageView.kf.setImage(with: viewModel.ownerImageURL)
        ownerHandleLabel.text = viewModel.ownerHandle
        repoTitleLabel.text = viewModel.name
        repoDescriptionLabel.text = viewModel.description
        
        if let lang = viewModel.language {
            repoLanguageLabel.label.text = lang
            repoLanguageLabel.imageView.tintColor = .systemBlue
            repoLanguageLabel.imageView.image = UIImage(named: "icon-coding")?.withRenderingMode(.alwaysTemplate)
        }
        
        repoStarsLabel.label.text = "\(viewModel.starsCount)"
        repoStarsLabel.imageView.image = UIImage(named: "icon-star")
        
    }
    
}

extension TrendingRepoTVCell {
    
    private func setupViews() {
        contentView.addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            ownerImageView.widthAnchor.constraint(equalToConstant: 50),
            ownerImageView.heightAnchor.constraint(equalToConstant: 50),
            
            repoStarsLabel.imageView.heightAnchor.constraint(equalToConstant: 18),
            repoLanguageLabel.imageView.heightAnchor.constraint(equalToConstant: 14),
            
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            contentView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 18),
            contentView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 18)
        ])
    }
}
