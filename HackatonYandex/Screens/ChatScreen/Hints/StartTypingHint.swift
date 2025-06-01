//
//  StartTypingHint.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

final class StartTypingHint: UIView {
    
    private let stackView = UIStackView()
    
    private var bottomConstraint: NSLayoutConstraint?
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Печатайте сообщение, чтобы показать и озвучить собеседнику"
        label.font = UIFont(name: "YSDisplay-Medium", size: 18)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
       }()
    
    private lazy var arrowIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(named: "startTypingHintIcon"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24)
        ])
        return icon
       }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    private func setupView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(arrowIcon)

        backgroundColor = .clear
        layer.cornerRadius = 12
        clipsToBounds = true
        alpha = 0
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    func show(over view: UIView, above anchorView: UIView, autoHideAfter delay: TimeInterval = 5.0) {
        view.addSubview(self)

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            widthAnchor.constraint(equalToConstant: 430),
            heightAnchor.constraint(equalToConstant: 159),
        ])

        // Привязываем bottom к верху anchorView (chatComponent)
        self.bottomConstraint = bottomAnchor.constraint(equalTo: anchorView.topAnchor, constant: 200)
        self.bottomConstraint?.isActive = true

        view.layoutIfNeeded()

        // Анимируем появление
        self.bottomConstraint?.constant = -16
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut],
                       animations: {
            self.alpha = 1.0
            view.layoutIfNeeded()
        })

        // Скрыть автоматически
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.hide()
        }
    }

    func hide() {
        self.bottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.3,
                       animations: {
            self.alpha = 0
            self.superview?.layoutIfNeeded()
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
