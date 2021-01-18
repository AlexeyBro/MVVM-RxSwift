//
//  SceneDelegate.swift
//  Trinity_Monsters
//
//  Created by Alex Bro on 14.01.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        let navigationController = UINavigationController()
        let assembly = AssemblyService()
        let router = RouterService(navigationController: navigationController, assembly: assembly)
        router.initialViewController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

