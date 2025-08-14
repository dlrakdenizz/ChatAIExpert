//
//  ChatRepository.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import Foundation
import UIKit
import FirebaseAI

class ChatRepository: ChatRepositoryProtocol {
    
    private let historyViewModel = HistoryViewModel.shared
    private let firebaseService: FirebaseAIService
    private var model: GenerativeModel
    private var chatSessions: [String: Chat] = [:]  // Her chatbot için ayrı chat session
    
    init(firebaseService: FirebaseAIService) {
        self.firebaseService = firebaseService
        self.model = firebaseService.createGenerativeModel()
    }
    
    func sendMessage(_ message: String, chatbotType: Chatbots, image: [UIImage]?) async throws -> String {
        
         //Her chatbot için ayrı chat session'ı al veya oluştur
        let chatKey = chatbotType.rawValue
        let chat: Chat
        
        if let existingChat = chatSessions[chatKey] {
            chat = existingChat
        } else {
            // İlk mesaj ise system prompt ile başlat
            let initialHistory = [
                ModelContent(role: "model", parts: chatbotType.systemPrompts)
            ]
            chat = model.startChat(history: initialHistory)
            chatSessions[chatKey] = chat
        }
        
        do {
                let response: GenerateContentResponse
                
                if let images = image, !images.isEmpty {
                    // Multiple image desteği
                    if images.count == 1 {
                        // Tek resim - mevcut yöntemle
                        let resizedImage = resizeImage(image: images[0], targetSize: CGSize(width: 1024, height: 1024))
                        response = try await chat.sendMessage(resizedImage, message)
                    } else {
                        // Multiple images - alternatif yaklaşım
                        var content: [any PartsRepresentable] = []
                        
                        // Text part ekle
                        content.append(message)
                        
                        // Her resim için part ekle
                        for image in images {
                            let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 1024, height: 1024))
                            content.append(resizedImage)
                        }
                        
                        // Direct content array gönder
                        response = try await chat.sendMessage(content)
                    }
                } else {
                    // Sadece text mesajı gönder
                    response = try await chat.sendMessage(message)
                }
                
                return response.text ?? "I couldn't understand, can you say again?"
            } catch {
                throw error
            }
    }
    
    // Chat history'yi temizle
    func clearChatHistory(for chatbotType: Chatbots) {
        let chatKey = chatbotType.rawValue
        chatSessions.removeValue(forKey: chatKey)
    }
    
    // **MARK: - Private Helper Methods**
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let ratio = min(widthRatio, heightRatio)
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? image
    }
}
