//
//  ChatComponent.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

class ChatComponent: UIView {
    
    let textField = UITextField()

    lazy var leftButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "leftChatButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    lazy var rightButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "rightChatButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
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

        textField.attributedPlaceholder = NSAttributedString(
            string: "Сообщение...",
            attributes: [
                .foregroundColor: UIColor.black.withAlphaComponent(0.45)
            ]
        )
        textField.backgroundColor = .textField
        textField.tintColor = .black
        textField.layer.cornerRadius = 8
        textField.borderStyle = .none
        textField.layer.cornerRadius = 14
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "YSDisplay-Medium", size: 20)

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        let stackView = UIStackView(arrangedSubviews: [leftButton, textField, rightButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            leftButton.widthAnchor.constraint(equalToConstant: 48),
            leftButton.heightAnchor.constraint(equalToConstant: 48),
            
            textField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            
            rightButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            rightButton.widthAnchor.constraint(equalTo: rightButton.heightAnchor),
        ])
    }
}
