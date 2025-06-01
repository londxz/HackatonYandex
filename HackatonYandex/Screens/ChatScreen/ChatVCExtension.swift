//
//  ChatVCExtension.swift
//  HackatonYandex
//
//  Created by Родион Холодов on 01.06.2025.
//

extension ChatVC: SegmentControlComponentDelegate {
    func segmentChanged(to index: Int) {
        switch index {
        case 0: switchToChild(talkVC)
        case 1: switchToChild(listenVC)
        default: break
        }
    }
}
