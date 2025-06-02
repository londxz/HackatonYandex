//
//  ChatVC.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit
import AVFoundation

class ChatVC: UIViewController {
    
    var chatComponentBottomConstraint: NSLayoutConstraint!
    
    private let topChatComponent = TopChatComponent()
    private let containerView = UIView()
    let segmentControlComponent = SegmentControlComponent()
    let chatComponent = ChatComponent()
    
    var typingHint: StartTypingHint?
    var microphoneHint: MicrophoneOnHint?
    
    private var currentChildVC: UIViewController?
    lazy var talkVC = TalkViewController()
    lazy var listenVC = ListenViewController()
    
    var microEnabledView: MicroEnabledView?
    var isViewRotated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundYandex
        setupKeyboardObservers()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        setupTopChatComponent()
        setupSegmentControlComponent()
        setupChatComponent()
        setupContainerView()
        
        segmentControlComponent.delegate = self
        talkVC.delegate = self
        
        switchToChild(talkVC)
        
        //UserDefaults.standard.removeObject(forKey: "hasSeenOnboarding")
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        currentChildVC?.viewDidDisappear(animated)
        
        resetRotationIfNeeded()
        
        typingHint?.hide()
        typingHint = nil
        
        microphoneHint?.hide()
        microphoneHint = nil
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
    
    private func setupSegmentControlComponent() {
        view.addSubview(segmentControlComponent)
        segmentControlComponent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentControlComponent.topAnchor.constraint(equalTo: topChatComponent.bottomAnchor, constant: 4),
            segmentControlComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 11),
            segmentControlComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -11),
            segmentControlComponent.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: segmentControlComponent.bottomAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: chatComponent.topAnchor, constant: -6)
        ])
    }
    
    private func setupChatComponent() {
        view.addSubview(chatComponent)
        chatComponent.translatesAutoresizingMaskIntoConstraints = false
        
        chatComponentBottomConstraint = chatComponent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        
        NSLayoutConstraint.activate([
            //chatComponent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            chatComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatComponent.heightAnchor.constraint(equalToConstant: 56),
            chatComponentBottomConstraint
        ])
    }
    
    func switchToChild(_ newVC: UIViewController) {
        // Remove current VC
        if let current = currentChildVC {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }
        
        // Add new VC
        addChild(newVC)
        containerView.addSubview(newVC.view)
        newVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            newVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            newVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            newVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        newVC.didMove(toParent: self)
        
        currentChildVC = newVC
    }
    
    func dismissMicrophoneOverlayIfNeeded() {
        guard let overlay = microEnabledView else { return }
        
        UIView.animate(withDuration: 0.3, animations: {
            overlay.alpha = 0
            overlay.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            overlay.removeFromSuperview()
        })
        
        microEnabledView = nil
    }
    
    func resetRotationIfNeeded() {
        guard isViewRotated else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.view.transform = .identity
        }
        isViewRotated = false
    }
    
    func toggleRotation() {
        isViewRotated.toggle()
        
        UIView.animate(withDuration: 0.3) {
            self.view.transform = self.isViewRotated ? CGAffineTransform(rotationAngle: .pi) : .identity
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
