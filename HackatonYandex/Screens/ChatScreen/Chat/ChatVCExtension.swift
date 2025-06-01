//
//  ChatVCExtension.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

extension ChatVC: SegmentControlComponentDelegate, TalkViewControllerDelegate, MicroEnabledViewDelegate {
    
    func segmentChanged(to index: Int) {
        typingHint?.hide()
        typingHint = nil
        
        microphoneHint?.hide()
        microphoneHint = nil
        
        switch index {
        case 0: switchToChild(talkVC)
        case 1: switchToChild(listenVC)
        default: break
        }
    }
    
    func showStartTypingHint() {
        let hint = StartTypingHint()
        hint.show(over: view, above: chatComponent)
        typingHint = hint
    }
    
    func showMicrophoneHint() {
        let hint = MicrophoneOnHint()
        hint.onTap = { [weak self] in
            self?.presentMicrophoneOverlay()
        }

        microphoneHint = hint
        hint.show(over: self.view, under: segmentControlComponent)
    }
    
    func presentMicrophoneOverlay() {
        microEnabledView?.removeFromSuperview()
        
        let overlay = MicroEnabledView()
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.alpha = 0
        overlay.transform = CGAffineTransform(scaleX: 1.1, y: 1.1) // чуть увеличен сначала

        view.addSubview(overlay)
        microEnabledView = overlay
        microEnabledView?.delegate = self
        
        NSLayoutConstraint.activate([
            overlay.topAnchor.constraint(equalTo: view.topAnchor),
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut],
                       animations: {
            overlay.alpha = 1
            overlay.transform = .identity
        }, completion: nil)
    }
    
    func didRequestRotationToggle() {
        toggleRotation()
    }
    
    func didRequestResetRotation() {
        resetRotationIfNeeded()
    }
}
