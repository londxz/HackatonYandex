//
//  MicroEnabledScreen.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 02.06.2025.
//

import UIKit

protocol MicroEnabledViewDelegate: AnyObject {
    func didRequestRotationToggle()
    func didRequestResetRotation()
}

class MicroEnabledView: UIView {
    var onDismiss: (() -> Void)?
    
    weak var delegate: MicroEnabledViewDelegate?
    
    private var playButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backgroundYandex

        setupLabel()
        setupButton()
        setupActionButtons()
    }
    
    private func setupLabel() {
        let label = UILabel()
        label.text = "Включен микрофон.\nГоворите.\nПостарайтесь говорить разборчиво и не очень быстро"
        label.numberOfLines = 0
        label.font = UIFont(name: "YSDisplay-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -24),
        ])
    }
    
    private func setupButton() {
        playButton = UIButton(type: .system)

        let image = UIImage(named: "playButtonIcon")?.withRenderingMode(.alwaysOriginal)

        var config = UIButton.Configuration.filled()
        config.title = "Воспроизвести"
        config.image = image
        config.imagePlacement = .leading
        config.imagePadding = 8

        config.baseForegroundColor = .black
        config.baseBackgroundColor = .yellowYandex
        config.cornerStyle = .large

        playButton.configuration = config
        playButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 18)

        addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            playButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            playButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }

    private func setupActionButtons() {
        let dismissBtn = UIButton(type: .system)
        dismissBtn.setImage(UIImage(named: "dismisIconMicroOnScreen")?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismissBtn.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        
        let rotateBtn = UIButton(type: .system)
        rotateBtn.setImage(UIImage(named: "rotateIconMicroOnScreen")?.withRenderingMode(.alwaysOriginal), for: .normal)
        rotateBtn.addTarget(self, action: #selector(rotateTapped), for: .touchUpInside)
        
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dismissBtn)
        
        rotateBtn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rotateBtn)

        NSLayoutConstraint.activate([
            dismissBtn.heightAnchor.constraint(equalToConstant: 56),
            dismissBtn.widthAnchor.constraint(equalTo: dismissBtn.widthAnchor),
            dismissBtn.trailingAnchor.constraint(equalTo: playButton.trailingAnchor),
            dismissBtn.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -24),
            
            rotateBtn.heightAnchor.constraint(equalToConstant: 56),
            rotateBtn.widthAnchor.constraint(equalTo: rotateBtn.widthAnchor),
            rotateBtn.leadingAnchor.constraint(equalTo: playButton.leadingAnchor),
            rotateBtn.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -24)
        ])
    }


    @objc private func dismissTapped() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            self.delegate?.didRequestResetRotation()
            self.removeFromSuperview()
            self.onDismiss?()
        }
    }
    
    @objc private func rotateTapped() {
        delegate?.didRequestRotationToggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


