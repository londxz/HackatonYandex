//
//  SegmentControlComponent.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

protocol SegmentControlComponentDelegate: AnyObject {
    func segmentChanged(to index: Int)
}

class SegmentControlComponent: UIView {
    
    private let titles = ["Разговаривать", "Слушать"]
    private var buttons: [UIButton] = []
    private let selectorView = UIView()
    private let stackView = UIStackView()
    private var selectorLeadingConstraint: NSLayoutConstraint?
    
    weak var delegate: SegmentControlComponentDelegate?
    private var selectedIndex = 0
    private let inset: CGFloat = 4

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        layoutIfNeeded()
        updateSelectorPosition(animated: false)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        layoutIfNeeded()
        updateSelectorPosition(animated: false)
    }

    private func setupView() {
        backgroundColor = .textField
        layer.cornerRadius = 12
        clipsToBounds = true
        
        selectorView.backgroundColor = .white
        selectorView.layer.cornerRadius = 10
        selectorView.layer.shadowColor = UIColor.black.cgColor
        selectorView.layer.shadowOpacity = 0.1
        selectorView.layer.shadowOffset = CGSize(width: 0, height: 2)
        selectorView.layer.shadowRadius = 4
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectorView)

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 18)
            button.setTitleColor(index == selectedIndex ? .black : .darkGray, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44),

            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),

            selectorView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            selectorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            selectorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -inset * 2)
        ])

        selectorLeadingConstraint = selectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset)
        selectorLeadingConstraint?.isActive = true
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        guard sender.tag != selectedIndex else { return }
        selectedIndex = sender.tag
        updateSelectorPosition(animated: true)
        updateButtonColors()
        delegate?.segmentChanged(to: selectedIndex)
    }

    private func updateSelectorPosition(animated: Bool) {
        let buttonWidth = bounds.width / CGFloat(buttons.count)
        selectorLeadingConstraint?.constant = CGFloat(selectedIndex) * buttonWidth + inset

        if animated {
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }

    private func updateButtonColors() {
        for (index, button) in buttons.enumerated() {
            button.setTitleColor(index == selectedIndex ? .black : .darkGray, for: .normal)
        }
    }

    func setSelectedIndex(_ index: Int, animated: Bool = false) {
        guard index == 0 || index == 1 else { return }
        selectedIndex = index
        updateSelectorPosition(animated: animated)
        updateButtonColors()
    }
}
