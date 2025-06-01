//
//  StartTypingHint.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

protocol MicrophoneOnHintDelegate: AnyObject {
    func microphoneHintTapped()
}

final class MicrophoneOnHint: UIView {
    
    var onTap: (() -> Void)?
    
    private let hintView = UIView()
    private let textStack = UIStackView()
    
    private let microphoneImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "microOnIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 21),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        return imageView
    }()
    
    lazy private var microphoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "YSDisplay-Medium", size: 18)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "YSDisplay-Medium", size: 18)
        label.textColor = .white
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "microOnHintArrowIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 21),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        return imageView
    }()
    
    private var topConstraint: NSLayoutConstraint?
    
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
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        hintView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hintView)
        
        hintView.backgroundColor = .microphoneOn
        hintView.layer.cornerRadius = 12
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hintTapped))
        hintView.isUserInteractionEnabled = true
        hintView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            hintView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            hintView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            hintView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            hintView.heightAnchor.constraint(equalToConstant: 82)
        ])
        
        setupContentView()
    }
    
    private func setupContentView() {
        microphoneLabel.text = "Микрофон включен"
        microphoneLabel.textColor = .microphoneLabelOn
        subLabel.text = "Сообщить собеседнику"
        
        textStack.translatesAutoresizingMaskIntoConstraints = false
        hintView.addSubview(textStack)
        
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.alignment = .leading
        textStack.distribution = .fill
        
        textStack.addArrangedSubview(microphoneLabel)
        textStack.addArrangedSubview(subLabel)
        
        addSubview(textStack)
        addSubview(microphoneImageView)
        addSubview(arrowImageView)
        
        microphoneLabel.isUserInteractionEnabled = false
        subLabel.isUserInteractionEnabled = false
        textStack.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            textStack.trailingAnchor.constraint(equalTo: hintView.trailingAnchor),
            textStack.centerYAnchor.constraint(equalTo: hintView.centerYAnchor),
            //textStack.bottomAnchor.constraint(equalTo: hintView.bottomAnchor)
            
            microphoneImageView.leadingAnchor.constraint(equalTo: hintView.leadingAnchor, constant: 12),
            microphoneImageView.topAnchor.constraint(equalTo: textStack.topAnchor),
            
            textStack.leadingAnchor.constraint(equalTo: microphoneImageView.trailingAnchor, constant: 6),
            
            arrowImageView.trailingAnchor.constraint(equalTo: hintView.trailingAnchor, constant: -14),
            arrowImageView.topAnchor.constraint(equalTo: textStack.topAnchor, constant: 4),
        ])
    }

    func show(over view: UIView, under anchorView: UIView, autoHideAfter delay: TimeInterval = 5.0) {
        view.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            widthAnchor.constraint(equalToConstant: 430),
            heightAnchor.constraint(equalToConstant: 159),
        ])
        
        // Привязываем topAnchor к anchorView.bottomAnchor — подсказка под сегментом
        self.topConstraint = topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: -100) // старт: выше
        self.topConstraint?.isActive = true

        view.layoutIfNeeded()
        
        // Анимация: выплываем вниз на позицию чуть ниже anchorView
        self.topConstraint?.constant = 8

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut],
                       animations: {
            self.alpha = 1.0
            view.layoutIfNeeded()
        })

        // Скрыть через delay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.hide()
        }
    }


    func hide() {
        self.topConstraint?.constant = 0
        UIView.animate(withDuration: 0.3,
                       animations: {
            self.alpha = 0
            self.superview?.layoutIfNeeded()
        }) { _ in
            self.removeFromSuperview()
        }
    }
       
    @objc private func hintTapped() {
        onTap?()
    }
}
