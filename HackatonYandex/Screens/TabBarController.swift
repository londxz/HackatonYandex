//
//  TabBarController.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundYandex
        print(1)
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundYandex
        print(2)
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundYandex
        print(3)
    }
}

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstVC = ChatVC()
        let secondVC = SecondViewController()
        let thirdVC = ThirdViewController()

        // Настройка вкладок
        firstVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "tabBarIcon1Disabled")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "tabBarIcon1Enabled")?.withRenderingMode(.alwaysOriginal))
        
        secondVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "tabBarIcon2Disabled")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "tabBarIcon2Enabled")?.withRenderingMode(.alwaysOriginal))
        
        thirdVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "tabBarIcon3Disabled")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "tabBarIcon3Enabled")?.withRenderingMode(.alwaysOriginal))

        viewControllers = [firstVC, secondVC, thirdVC]
    }
}
