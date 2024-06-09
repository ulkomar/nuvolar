//
//  ViewController.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit
import Combine

protocol MainSearchViewControllerLogic: UIViewController {
    var viewModel: MainSearchViewModelLogic { get }
    var coordinator: Coordinator? { get set }
}

final class MainSearchViewController: BaseViewController, MainSearchViewControllerLogic {
    
    // MARK: - Data source
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, UserModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, UserModel>
    
    private var dataSource: DataSource?
    
    // MARK: - GUI elements
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: listLayout()
    )
    private lazy var searchingImage = UIImageView()
    private lazy var searchController = UISearchController(searchResultsController: nil)
    private let searchTextPublisher = PassthroughSubject<String, Never>()
    
    // MARK: - ViewModel
    
    let viewModel: MainSearchViewModelLogic
    
    // MARK: - Initialization
    
    init(viewModel: MainSearchViewModelLogic) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Data Source
    
    func configureDataSource() {
        dataSource = DataSource(
            collectionView: self.collectionView
        ) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserCell.identifier,
                for: indexPath
            )
            guard let cell = cell as? UserCell else { return cell }
            cell.set(userImage: item.image, userName: item.name)
            return cell
        }
        collectionView.dataSource = dataSource
        
    }
    
    func configureSnapshot(items: [UserModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        self.dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UICollectionViewDelegate

extension MainSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.tapped(at: indexPath.row)
    }
}

// MARK: - UISearchControll

extension MainSearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextPublisher.send(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancellSearchButtonTapped()
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        viewModel.searchingFieldStatedChanged(isFocused: true)

    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.searchingFieldStatedChanged(isFocused: false)
    }
}

// MARK: - Layout

extension MainSearchViewController: LayoutConfigurableView {
    func configureViewProperties() {
        view.backgroundColor = .systemBackground
        navigationItem.title = String(localized: "mainSearch-search-bar")
        navigationItem.searchController = searchController
        setNavigationBackButtonVisibility(for: .hidden)
    }
    
    func configureSubviews() {
        view.addSubview(searchingImage)
        searchingImage.translatesAutoresizingMaskIntoConstraints = false
        searchingImage.image = UIImage(resource: .searching)
        searchingImage.contentMode = .scaleAspectFit
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        view.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.register(cellType: UserCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -15),
            
            searchingImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchingImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchingImage.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.5),
            searchingImage.widthAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.sendSearchRequestForPaging(currentVisibleIndex: indexPath.row)
    }
}

// MARK: - Binding

extension MainSearchViewController: BindingConfigurableView {
    func bindInner() {
        viewModel.state
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .emptyViewShowing:
                    UIView.animate(withDuration: 0.5) {
                        self.collectionView.isHidden = true
                        self.searchingImage.isHidden = false
                        self.searchingImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }
                case .searchingModeShowing:
                    self.searchingImage.isHidden = true
                    self.searchingImage.transform = CGAffineTransform(scaleX: 0, y: 0)
                    self.collectionView.isHidden = false
                    break
                case .updateModels(let models):
                    configureSnapshot(items: models)
                }
            }
            .store(in: &cancellables)
    }
    
    func bindOutput() {
        searchTextPublisher
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                guard !searchText.isEmpty else { return }
                self?.viewModel.sendSearchRequest(for: searchText, page: 0)
            }
            .store(in: &cancellables)
    }
}
