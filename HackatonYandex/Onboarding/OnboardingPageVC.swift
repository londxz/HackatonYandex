//
//  OnboardingPageVC.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

class OnboardingPageVC: UIPageViewController {
    private var pagesDataSource: [OnboardingPageModel] = []
    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = nil
        delegate = nil
        view.backgroundColor = .white

        pagesDataSource = [
            OnboardingPageModel(imageName: "onboardingIcon1", title: "Разговаривайте с помощью текста", subtitle: "Приложение покажет на экране, что говорит собеседник. А вы можете написать ответ и озвучить его голосом.", isLast: false),
            OnboardingPageModel(imageName: "onboardingIcon2", title: "Читайте речь вокруг вас", subtitle: "Откройте приложение, и оно начнёт превращеть в текст речь одного или более спикеров. Удобно, когда  нужно только слушать.", isLast: false),
            OnboardingPageModel(imageName: "onboardingIcon3", title: "Быстрые фразы под рукой", subtitle: "Показывайте или озвучивайте заранее сохранённые фразы.", isLast: true)
        ]
        
        showPage(index: 0)
    }

    func showPage(index: Int) {
        let pageVC = OnboardingContentVC(page: pagesDataSource[index])
        pageVC.onNext = { [weak self] in
            guard let self = self else { return }
            if index < self.pagesDataSource.count - 1 {
                self.showPage(index: index + 1)
            } else {
                self.finishOnboarding()
            }
        }
        pageVC.onSkip = { [weak self] in
            self?.finishOnboarding()
        }
        setViewControllers([pageVC], direction: .forward, animated: true, completion: nil)
    }

    func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        let mainVC = ViewController()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else { return }
        
        let tabBar = TabBarController()
        
        UIView.transition(with: keyWindow, duration: 0.5, options: .transitionCurlDown) {
            keyWindow.rootViewController = tabBar
            keyWindow.makeKeyAndVisible()
        }
    }
}
