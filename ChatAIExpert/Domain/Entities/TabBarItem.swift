//
//  TabBarItem.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import Foundation

struct TabBarItem: Hashable, CaseIterable {
    let id: Int
    let name: String
    let icon: String
    
    static let chatAI = TabBarItem(id: 0, name: NSLocalizedString("chatAI", comment: ""), icon: "brain.head.profile.fill")
    static let chatbots = TabBarItem(id: 1, name: NSLocalizedString("chatbots", comment: ""), icon: "message")
    static let history = TabBarItem(id: 2, name: NSLocalizedString("history", comment: ""), icon: "clock")
    
    static var allCases: [TabBarItem] {
        return [.chatbots, .history]
    }
}
