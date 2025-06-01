//
//  ChatVC.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

class ChatVC: UIViewController {
    
    let chatComponent = ChatComponent()
    let topChatComponent = TopChatComponent()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundYandex
        //UserDefaults.standard.removeObject(forKey: "hasSeenOnboarding")
        setupChatComponent()
        setupTopChatComponent()
    }

    private func setupChatComponent() {
        view.addSubview(chatComponent)
        chatComponent.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chatComponent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            chatComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatComponent.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupTopChatComponent() {
        view.addSubview(topChatComponent)
        topChatComponent.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topChatComponent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topChatComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topChatComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topChatComponent.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
