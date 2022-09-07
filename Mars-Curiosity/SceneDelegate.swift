//
//  SceneDelegate.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 5/9/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let builder = Builder()
    let navigationController = UINavigationController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let router = Router(navigationController: navigationController, builder: builder)
        router.initialViewController()
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }
}
