//
//  ChatViewModel.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 19.07.2025.
//

import SwiftUI

class ChatViewModel : ObservableObject {
    
    @Published var messages = [Message]()
    @Published var isResponding = false
    @Published var shareText: String = ""
    
    private let chatbotType: Chatbots
    private let historyViewModel = HistoryViewModel.shared
    private var historyId: String?
    private var createdAt: Date = Date()
    private let settingsRepository = SettingsRepository()
    private var messageCount: Int = 0
    
    private let sendMessageUseCase: SendMessageUseCaseProtocol
    private let shareChatUseCase: ShareChatUseCaseProtocol
    private let repository: ChatRepositoryProtocol  // Repository'yi direkt erişim için tutuyoruz
    
    init(chatbotType: Chatbots,
         historyId: String? = nil,
         sendMessageUseCase: SendMessageUseCaseProtocol,
         shareChatUseCase: ShareChatUseCaseProtocol,
         repository: ChatRepositoryProtocol) {
        self.chatbotType = chatbotType
        self.historyId = historyId
        self.sendMessageUseCase = sendMessageUseCase
        self.shareChatUseCase = shareChatUseCase
        self.repository = repository
        
        if let historyId = historyId,
           let history = historyViewModel.chatHistories.first(where: { $0.id == historyId }) {
            messages = history.messages
            createdAt = history.createdAt
            messageCount = history.messages.count
        } else {
            let welcomeMessage = Message(
                isFromCurrentUser: false,
                messageText: chatbotType.welcomeMessage
            )
            messages.append(welcomeMessage)
            createdAt = Date()
            messageCount = 0
        }
    }
    
    func clearMessages() {
        messages = [Message(
            isFromCurrentUser: false,
            messageText: chatbotType.welcomeMessage
        )]
        historyId = nil
        createdAt = Date()
        
        // Firebase AI chat history'yi de temizle
        repository.clearChatHistory(for: chatbotType)
    }
    
    func sendMessage(_ message: String, image: UIImage? = nil) {
        
               // Soru hakkını azalt
               settingsRepository.decrementQuestionCredits()

        let userMessage = Message(
            isFromCurrentUser: true,
            messageText: message,
            imageData: image?.jpegData(compressionQuality: 0.8)
        )
        messages.append(userMessage)
        
        let typingMessage = Message(
            isFromCurrentUser: false,
            messageText: "",
            isTyping: true
        )
        messages.append(typingMessage)
        
        isResponding = true
        
        Task {
            do {
                let response = try await sendMessageUseCase.execute(
                    message: message,
                    chatbotType: chatbotType,
                    image: image
                )
                
                await MainActor.run {
                    messages.removeLast()
                    let botMessage = Message(
                        isFromCurrentUser: false,
                        messageText: response
                    )
                    messages.append(botMessage)
                    isResponding = false
                    saveCurrentHistory()
                }
            } catch {
                await MainActor.run {
                    messages.removeLast()
                    let errorMessage = Message(
                        isFromCurrentUser: false,
                        messageText: "Create an error. I can't respond."
                    )
                    messages.append(errorMessage)
                    isResponding = false
                }
            }
        }
    }
    
    private func saveCurrentHistory() {
        let id = historyId ?? UUID().uuidString
        let history = ChatHistory(
            id: id,
            chatbotType: chatbotType,
            messages: messages,
            createdAt: createdAt,
            updatedAt: Date()
        )
        historyViewModel.saveHistory(history)
        historyId = id
    }
    
    func prepareShareText() {
            shareText = shareChatUseCase.execute(messages: messages, chatbotTitle: chatbotType.title)
        }
}
