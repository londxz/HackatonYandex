//
//  OnboardingContentViewController.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

class OnboardingContentVC: UIViewController {
    private let page: OnboardingPageModel
    var onNext: (() -> Void)?
    var onSkip: (() -> Void)?
    
    lazy var imageView: UIImageView = {
        let img = UIImageView(image: UIImage(named: page.imageName))
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            img.widthAnchor.constraint(equalToConstant: 250),
            img.heightAnchor.constraint(equalTo: img.widthAnchor)
        ])
        
        return img
    }()
    
    private var mainStack = UIStackView()
    private var buttonStack = UIStackView()

    init(page: OnboardingPageModel) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundYandex
        
        setupTextStack()
        setupButtonStack()
        
    }
    
    private func setupTextStack() {
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = page.title
        titleLabel.font = UIFont(name: "YSDisplay-Bold", size: 40)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = page.subtitle
        subtitleLabel.font = .systemFont(ofSize: 20)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .black
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mainStack = UIStackView()
        
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(titleView)
        mainStack.addArrangedSubview(subtitleLabel)
        
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor)
        ])
    }
    
    private func setupButtonStack() {
        
        let primaryButton = UIButton(type: .system)
        primaryButton.setTitle(page.isLast ? "Начать" : "Дальше", for: .normal)
        primaryButton.backgroundColor = .systemYellow
        primaryButton.setTitleColor(.black, for: .normal)
        primaryButton.layer.cornerRadius = 16
        primaryButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        primaryButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        let skipButton = UIButton(type: .system)
        skipButton.setTitle("Пропустить", for: .normal)
        
        if page.isLast {
            skipButton.setTitleColor(.backgroundYandex, for: .normal)
            skipButton.isEnabled = false
        } else {
            skipButton.setTitleColor(.black, for: .normal)
        }
        
        skipButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        
        buttonStack = UIStackView()
        
        buttonStack.axis = .vertical
        buttonStack.spacing = 0
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStack.addArrangedSubview(primaryButton)
        buttonStack.addArrangedSubview(skipButton)
        
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            primaryButton.heightAnchor.constraint(equalToConstant: 64),
            skipButton.heightAnchor.constraint(equalTo: primaryButton.heightAnchor)
        ])
    }
    
    @objc func nextTapped() { onNext?() }
    @objc func skipTapped() { onSkip?() }
}

