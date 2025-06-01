//
//  ViewController.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

import UIKit

class ViewController: UIViewController {

    // MARK: UI Elements

    private let speakButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Разговаривать", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()

    private let listenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Слушать", for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()

    private let micStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "🟢 Микрофон включен\nСообщить собеседнику"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        label.backgroundColor = UIColor.systemGray6
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()

    private let messageField: UITextField = {
        let field = UITextField()
        field.placeholder = "Сообщение..."
        field.borderStyle = .roundedRect
        return field
    }()

    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        button.tintColor = .systemYellow
        button.contentMode = .scaleAspectFit
        return button
    }()

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    private func setupLayout() {
        // Добавляем все элементы на экран
        [speakButton, listenButton, micStatusLabel, messageField, sendButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        // Пример constraints (упрощённо)
        NSLayoutConstraint.activate([
            speakButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            speakButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            speakButton.widthAnchor.constraint(equalToConstant: 140),
            speakButton.heightAnchor.constraint(equalToConstant: 40),

            listenButton.topAnchor.constraint(equalTo: speakButton.topAnchor),
            listenButton.leadingAnchor.constraint(equalTo: speakButton.trailingAnchor, constant: 10),
            listenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            listenButton.heightAnchor.constraint(equalTo: speakButton.heightAnchor),

            micStatusLabel.topAnchor.constraint(equalTo: speakButton.bottomAnchor, constant: 30),
            micStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            micStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            micStatusLabel.heightAnchor.constraint(equalToConstant: 60),

            messageField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            messageField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
            messageField.heightAnchor.constraint(equalToConstant: 40),

            sendButton.centerYAnchor.constraint(equalTo: messageField.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            sendButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

