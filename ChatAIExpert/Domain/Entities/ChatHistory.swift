//
//  ChatHistory.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import Foundation
import SwiftData

@Model
final class ChatHistory {
    var id: String
    var chatbotType: String
    var messages: [Message]
    var createdAt: Date
    var updatedAt: Date
    var customTitle: String?
    
    init(id: String, chatbotType: Chatbots, messages: [Message], createdAt: Date, updatedAt: Date) {
        self.id = id
        self.chatbotType = chatbotType.rawValue
        self.messages = messages
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.customTitle = nil
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: updatedAt)
    }
    
    var displayTitle: String {
        customTitle ?? Chatbots(rawValue: chatbotType)?.title ?? "Unknown"
    }
}

