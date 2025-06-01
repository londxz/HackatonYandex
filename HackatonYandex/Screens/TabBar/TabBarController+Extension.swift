//
//  TabBarController+Extension.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 02.06.2025.
//

import UIKit

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let chatVC = viewController as? ChatVC {
            chatVC.dismissMicrophoneOverlayIfNeeded()
        }
    }
}
