//
//  SceneDelegate.swift
//  DragonBall_practica-iOS
//
//  Created by Sergio Amo on 29/9/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let initialViewController = initialViewController()
        let navigationController = UINavigationController(rootViewController: initialViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

