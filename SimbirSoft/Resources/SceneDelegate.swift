//
//  SceneDelegate.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .systemBackground

        let module = ModuleBuilder.buildCalendarScene()
        let navigationController = UINavigationController(rootViewController: module)
        navigationController.navigationBar.backgroundColor = .systemBackground

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
