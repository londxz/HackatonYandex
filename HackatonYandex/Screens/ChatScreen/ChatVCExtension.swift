//
//  ChatVCExtension.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

extension ChatVC: SegmentControlComponentDelegate, TalkViewControllerDelegate {
    
    func segmentChanged(to index: Int) {
        typingHint?.hide()
        typingHint = nil
        
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
}
