//
//  ChatVCExtension.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

import UIKit

extension ChatVC: SegmentControlComponentDelegate, TalkViewControllerDelegate {
    
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
            guard let self = self else { return }
            let newVC = MicroEnabledScreen()
                
            self.present(newVC, animated: true, completion: nil)
        }

        microphoneHint = hint
        hint.show(over: self.view, under: segmentControlComponent)
    }
}
