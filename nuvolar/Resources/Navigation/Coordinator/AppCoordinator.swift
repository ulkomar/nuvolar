//
//  AppCoordinator.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properteis
    
    private let navigationService: NavigationServicesLogic
    
    // MARK: - Initialization
    
    init(navigationService: NavigationServicesLogic = NavigationServices.shared) {
        self.navigationService = navigationService
    }
    
    // MARK: - Start

    func start(with windowsScene: UIWindowScene) {
       // Here we can implement logic of starting different coordinators
        
        navigationService.setup(scene: windowsScene, firstVCS: [UIViewController()])
        let initialCoordinator = MainSearchCoordinator()
        initialCoordinator.start(from: .next)
    }
}
