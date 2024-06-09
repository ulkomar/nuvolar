//
//  MainSearchModuleFactory.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

protocol MainSearchModuleFactoryLogic {
    func makeMainScreen() -> MainSearchViewControllerLogic
    func makeDetailedScreen(user: GitHubUsersModel.Item) -> DetailedSearchUserViewControllerLogic
}

struct MainSearchModuleFactory: MainSearchModuleFactoryLogic {
    func makeMainScreen() -> MainSearchViewControllerLogic {
        let vm = MainSearchViewModel()
        let vc = MainSearchViewController(viewModel: vm)
        
        return vc
    }
    
    func makeDetailedScreen(user: GitHubUsersModel.Item) -> DetailedSearchUserViewControllerLogic {
        let vm = DetailedSearchUserViewModel(user: user)
        let vc = DetailedSearchUserViewController(viewModel: vm)
        
        return vc
    }
}
