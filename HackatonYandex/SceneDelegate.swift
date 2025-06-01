//
//  SceneDelegate.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController(rootViewController: ViewController())
        
        let isOnboarding = UserDefaults.standard.value(forKey: "hasSeenOnboarding") as? Bool ?? false
        let OnboardingPageVC = OnboardingPageVC(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        window.rootViewController = isOnboarding ? TabBarController() : OnboardingPageVC
        self.window = window
        window.makeKeyAndVisible()
    }

}

