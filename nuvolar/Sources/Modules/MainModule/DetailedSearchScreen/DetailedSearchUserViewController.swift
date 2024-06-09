//
//  DetailedSearchUserViewController.swift
//  nuvolar
//
//  Created by Developer on 8.06.24.
//

import UIKit

protocol DetailedSearchUserViewControllerLogic: UIViewController {
    var viewModel: DetailedSearchUserViewModelLogic { get }
}

final class DetailedSearchUserViewController: BaseViewController, DetailedSearchUserViewControllerLogic {
    
    // MARK: - ViewModel
    
    let viewModel: DetailedSearchUserViewModelLogic
    
    // MARK: - GUI
    
    private lazy var scrollView = UIScrollView()
    private lazy var commonStack = UIStackView()
    
    private lazy var avatarView = ImageTextView()
    private lazy var name = InfoblockView()
    private lazy var userType = InfoblockView()
    private lazy var company = InfoblockView()
    private lazy var createdAt = InfoblockView()
    private lazy var updatedAt = InfoblockView()
    private lazy var followersBlock = InfoblockView()
    private lazy var followingBlock = InfoblockView()
    private lazy var repoBlock = InfoblockView()
    
    // MARK: - Initialization
    
    init(viewModel: DetailedSearchUserViewModelLogic) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground
        configureView()
        viewModel.prepareForDisplayint()
    }
    
    // MARK: - Builders
    
    private func getTruncatedList(list: [String], moreText: String, maxVisibleCount: Int) -> [String] {
        if list.count > maxVisibleCount {
            return list[0...maxVisibleCount - 1] + ["+ \(list.count - maxVisibleCount) \(moreText)"]
        } else {
            return list
        }
    }
}

// MARK: -

extension DetailedSearchUserViewController: LayoutConfigurableView {
    func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.addSubview(commonStack)
        commonStack.addArrangedSubviews([
            avatarView,
            name,
            userType,
            company,
            createdAt,
            updatedAt,
            followersBlock,
            followingBlock,
            repoBlock
        ])
        commonStack.translatesAutoresizingMaskIntoConstraints = false
        commonStack.setCustomSpacing(30, after: avatarView)
        commonStack.axis = .vertical
        commonStack.spacing = 15
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            commonStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            commonStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            commonStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

extension DetailedSearchUserViewController: BindingConfigurableView {
    func bindInner() {
        viewModel.state
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .initial(let user):
                    avatarView.label = user.login
                    userType.set(title: String(localized: "detailed-screen-user-type"), body: user.type)
                    company.title = String(localized: "detailed-screen-company")
                    followersBlock.title = String(localized: "detailed-screen-followers")
                    followingBlock.title = String(localized: "detailed-screen-followers")
                    repoBlock.title = String(localized: "mainSearch-repos")
                    name.title = String(localized: "name")
                    createdAt.title = String(localized: "detailed-screen-created")
                    updatedAt.title = String(localized: "detailed-screen-updated")
                case .updatingFollowers(let followers):
                    if followers.isEmpty {
                        followersBlock.body = String(localized: "no").capitalized + " " + String(localized: "detailed-screen-followers")
                        return
                    }
                    followersBlock.list = getTruncatedList(
                        list: followers,
                        moreText: String(localized: "detailed-screen-followers"),
                        maxVisibleCount: 5
                    )
                case .updatingFollowings(let followings):
                    if followings.isEmpty {
                        followingBlock.body = String(localized: "no").capitalized + " " + String(localized: "detailed-screen-followings")
                        return
                    }
                    followingBlock.list = getTruncatedList(
                        list: followings,
                        moreText: String(localized: "detailed-screen-followers"),
                        maxVisibleCount: 5
                    )
                case .updatingRepos(let repos):
                    if repos.isEmpty {
                        repoBlock.body = String(localized: "no").capitalized + " " + String(localized: "mainSearch-repos")
                        return
                    }
                    repoBlock.list = getTruncatedList(
                        list: repos,
                        moreText: String(localized: "mainSearch-repos"),
                        maxVisibleCount: 10
                    )
                case .updatingUserInfo(let info):
                    createdAt.body = info.createdAt.toReadableDateFormatt() ?? String(localized: "undetermined").capitalized
                    updatedAt.body = info.updatedAt.toReadableDateFormatt() ?? String(localized: "undetermined").capitalized
                    name.body = info.name ?? String(localized: "undetermined").capitalized
                    company.body = info.company ?? String(localized: "undetermined").capitalized
                }
            }
            .store(in: &cancellables)
    }
}
