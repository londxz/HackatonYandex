//
//  TalkViewController.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

protocol TalkViewControllerDelegate: AnyObject {
    func showStartTypingHint()
    func showMicrophoneHint()
}

class TalkViewController: UIViewController {
    
    weak var delegate: TalkViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .chatBackground
        
        let label = UILabel()
        label.text = "Режим разговора"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.showStartTypingHint()
        delegate?.showMicrophoneHint()
    }
}
