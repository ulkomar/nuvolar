//
//  SceneDelegate.swift
//  nuvolar
//
//  Created by Developer on 6.06.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

//    var window: UIWindow?
    var appCoordinator = AppCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        appCoordinator.start(with: windowScene)
    }
}

