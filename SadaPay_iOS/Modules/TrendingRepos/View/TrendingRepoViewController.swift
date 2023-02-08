
import Foundation
import UIKit
import Combine
import SadaPayKit

class TrendingReposViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()
        
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: TrendingReposViewModelType
    private var cellViewModels: [ReusableViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(viewModel: TrendingReposViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        registerCells()
        bindViewModel()
        
        viewModel.reload()
    }
    
    @objc
    func refresh() {
        viewModel.reload()
    }

}

extension TrendingReposViewController {
    
    private func setupViews() {
        title = "Trending"
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
    
    private func registerCells() {
        tableView.register(TrendingRepoTVCell.self, forCellReuseIdentifier: TrendingRepoTVCell.identifier)
        tableView.register(TrendingRepoShimmeringTVCell.self, forCellReuseIdentifier: TrendingRepoShimmeringTVCell.identifier)
    }
    
}

extension TrendingReposViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = cellViewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.identifier, for: indexPath) as? ConfigurableTableViewCell
        cell?.configure(viewModel: viewModel)
        return cell ?? UITableViewCell()
    }
}

extension TrendingReposViewController {
    
    private func bindViewModel() {
        viewModel.cellViewModels
            .sink { [weak self] viewModels in
                self?.hideError()
                self?.refreshControl.endRefreshing()
                self?.cellViewModels = viewModels
            }
            .store(in: &cancellables)
        
        viewModel.error
            .sink { [weak self] error in
                self?.showError(error)
            }
            .store(in: &cancellables)
    }
    
    func showError(_ message: String) {
        
    }
    
    func hideError() {

    }
}


