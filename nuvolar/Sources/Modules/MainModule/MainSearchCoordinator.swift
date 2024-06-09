//
//  MainSearchCoordinator.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

final class MainSearchCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let modulesFactory: MainSearchModuleFactoryLogic
    private let navigationService: NavigationServicesLogic
    
    // MARK: - Initialization
    
    init(
        modulesFactory: MainSearchModuleFactoryLogic = MainSearchModuleFactory(),
        navigationService: NavigationServicesLogic = NavigationServices.shared
    ) {
        self.modulesFactory = modulesFactory
        self.navigationService = navigationService
        super.init()
    }
    
    // MARK: - Start coordinator
    
    func start(from entryPoint: EntryPoint ) {
        switch entryPoint {
        case .deeplink:
            break
        case .next:
            navigationService.pushVC(makeMainSearchScreen(), animated: true)
        }
    }
    
    // MARK: - Creating screens
    
    private func makeMainSearchScreen() -> MainSearchViewControllerLogic {
        let module = modulesFactory.makeMainScreen()
        module.coordinator = self
        module.viewModel.event
            .sink { [weak self] event in
                switch event {
                case .tappedUser(let user):
                    self?.openDetailedUserScreen(for: user)
                }
            }
            .store(in: &cancellables)
        return module
    }
    
    private func openDetailedUserScreen(for user: GitHubUsersModel.Item) {
        let module = modulesFactory.makeDetailedScreen(user: user)
        module.viewModel.event
            .sink { [weak self] event in
                switch event {
                    
                }
            }
            .store(in: &cancellables)
        navigationService.pushVC(module, animated: true)
    }
}

// MARK: - Entry Point

extension MainSearchCoordinator {
    enum EntryPoint {
        case deeplink // can be implemented via different ways of appearing
        case next
    }
}
