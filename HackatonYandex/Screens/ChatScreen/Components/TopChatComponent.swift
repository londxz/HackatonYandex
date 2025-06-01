//
//  TopChatComponent.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

class TopChatComponent: UIView {
    
    lazy var microNavButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "microNavBarIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    lazy var leftNavButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "leftNavBarIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    lazy var rightNavButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "rightNavBarIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(microNavButton)
        addSubview(leftNavButton)
        addSubview(rightNavButton)
        
        NSLayoutConstraint.activate([
            microNavButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            microNavButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            microNavButton.widthAnchor.constraint(equalToConstant: 48),
            microNavButton.heightAnchor.constraint(equalTo: microNavButton.widthAnchor),
            
            leftNavButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftNavButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            leftNavButton.widthAnchor.constraint(equalToConstant: 24),
            leftNavButton.heightAnchor.constraint(equalTo: leftNavButton.widthAnchor),
            
            rightNavButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightNavButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            rightNavButton.widthAnchor.constraint(equalToConstant: 24),
            rightNavButton.heightAnchor.constraint(equalTo: leftNavButton.widthAnchor)
        ])
    }
}
