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
    
    lazy var textRightButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "rightChatButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    lazy var speakRightButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "speakRightChatButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        textField.delegate = self
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        textRightButton.addGestureRecognizer(longPressRecognizer)
        
        speakRightButton.addTarget(self, action: #selector(speakButtonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        textField.delegate = self
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        textRightButton.addGestureRecognizer(longPressRecognizer)

        speakRightButton.addTarget(self, action: #selector(speakButtonTapped), for: .touchUpInside)
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
        
        let stackView = UIStackView(arrangedSubviews: [leftButton, textField, textRightButton, speakRightButton])
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
            
            textRightButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            textRightButton.widthAnchor.constraint(equalTo: textRightButton.heightAnchor),
            
            speakRightButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            speakRightButton.widthAnchor.constraint(equalTo: speakRightButton.heightAnchor)
        ])
    }
    
    private func startRecordingAnimation() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.fromValue = 1.0
        pulse.toValue = 1.15
        pulse.duration = 0.6
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        speakRightButton.layer.add(pulse, forKey: "pulse")
    }

    private func stopRecordingAnimation() {
        speakRightButton.layer.removeAnimation(forKey: "pulse")
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            textRightButton.isHidden = true
            speakRightButton.isHidden = false
            startRecordingAnimation()
            print("Удержание: показан speakRightButton и началась анимация")
        }
    }

    @objc private func speakButtonTapped() {
        speakRightButton.isHidden = true
        textRightButton.isHidden = false
        stopRecordingAnimation()
        print("Нажатие: вернули textRightButton и остановили анимацию")
    }
}

extension ChatComponent: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(1) // Вывод 1 в консоль
        return true
    }
}
