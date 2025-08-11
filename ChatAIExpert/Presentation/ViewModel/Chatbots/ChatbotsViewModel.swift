//
//  ChatbotsViewModel.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import SwiftUI

class ChatbotsViewModel : ObservableObject {
    
    @Published var selectedCategory: ChatbotCategory = .relationship
    @Published var chatbots: [Chatbots] = []
    
    private let getChatbotsByCategoryUseCase: GetChatbotsByCategoryUseCaseProtocol
    private let manageSavedChatbotsUseCase: ManageSavedChatbotsUseCaseProtocol
    
    init(getChatbotsByCategoryUseCase: GetChatbotsByCategoryUseCaseProtocol,
         manageSavedChatbotsUseCase: ManageSavedChatbotsUseCaseProtocol) {
        self.getChatbotsByCategoryUseCase = getChatbotsByCategoryUseCase
        self.manageSavedChatbotsUseCase = manageSavedChatbotsUseCase
        filterChatbots()
    }
    
    func selectCategory(_ category: ChatbotCategory) {
        selectedCategory = category
        filterChatbots()
    }
    
    private func filterChatbots() {
        chatbots = getChatbotsByCategoryUseCase.execute(category: selectedCategory)
    }
    
    func removeChatbot(_ chatbot: Chatbots) {
        chatbots.removeAll { $0 == chatbot }
    }
    
    func saveChatbot(_ chatbot: Chatbots) {
        manageSavedChatbotsUseCase.saveChatbot(chatbot)
        NotificationCenter.default.post(name: NSNotification.Name("UpdateSavedChatbots"), object: nil)
    }
    
    func unsaveChatbot(_ chatbot: Chatbots) {
        manageSavedChatbotsUseCase.unsaveChatbot(chatbot)
        NotificationCenter.default.post(name: NSNotification.Name("UpdateSavedChatbots"), object: nil)
    }
    
    func isChatbotSaved(_ chatbot: Chatbots) -> Bool {
        return manageSavedChatbotsUseCase.isChatbotSaved(chatbot)
    }
}
