//
//  ShareChatUseCase.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 22.07.2025.
//

import Foundation

protocol ShareChatUseCaseProtocol {
    func execute(messages: [Message], chatbotTitle: String) -> String
}

final class ShareChatUseCase: ShareChatUseCaseProtocol {
    func execute(messages: [Message], chatbotTitle: String) -> String {
        var chatText = "Chat with \(chatbotTitle)\n\n"
        
        for message in messages {
            let sender = message.isFromCurrentUser ? "Me" : chatbotTitle
            chatText += "\(sender): \(message.messageText)\n\n"
        }
        
        return chatText
    }
}

