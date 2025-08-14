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
    
    static var chatbots: TabBarItem {
        TabBarItem(id: 0, name: localized("chatbots"), icon: "message")
    }
    
    static var history: TabBarItem {
        TabBarItem(id: 1, name: localized("history"), icon: "clock")
    }
    
    static var allCases: [TabBarItem] {
        return [.chatbots, .history]
    }
} 
