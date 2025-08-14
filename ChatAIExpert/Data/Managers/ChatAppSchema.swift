//
//  ChatAppSchema.swift
//  ChatAIExpert
//
//  Created by Dilara Akdeniz on 14.08.2025.
//

import SwiftData
import Foundation

enum ChatAppSchema {
    
    // V1: imageData'nın tekil Data? olduğu eski versiyon
    enum V1: VersionedSchema {
        static var versionIdentifier: Schema.Version = .init(1, 0, 0)
        
        static var models: [any PersistentModel.Type] {
            [ChatHistoryV1.self]
        }
        
        @Model
        final class ChatHistoryV1 {
            var id: String
            var chatbotType: String
            var messages: [MessageV1]
            var createdAt: Date
            var updatedAt: Date
            var customTitle: String?

            init(id: String, chatbotType: String, messages: [MessageV1], createdAt: Date, updatedAt: Date, customTitle: String?) {
                self.id = id
                self.chatbotType = chatbotType
                self.messages = messages
                self.createdAt = createdAt
                self.updatedAt = updatedAt
                self.customTitle = customTitle
            }
        }

        struct MessageV1: Codable, Identifiable {
            var id: String
            let isFromCurrentUser: Bool
            let messageText: String
            var isTyping: Bool
            var imageData: Data?
        }
    }
    
    // V2: imageData'nın [Data]? olduğu yeni versiyon
    enum V2: VersionedSchema {
        static var versionIdentifier: Schema.Version = .init(2, 0, 0)
        
        static var models: [any PersistentModel.Type] {
            [ChatHistoryV2.self]
        }
        
        @Model
        final class ChatHistoryV2 {
            var id: String
            var chatbotType: String
            var messages: [MessageV2]
            var createdAt: Date
            var updatedAt: Date
            var customTitle: String?

            init(id: String, chatbotType: String, messages: [MessageV2], createdAt: Date, updatedAt: Date, customTitle: String?) {
                self.id = id
                self.chatbotType = chatbotType
                self.messages = messages
                self.createdAt = createdAt
                self.updatedAt = updatedAt
                self.customTitle = customTitle
            }
            
            var formattedDate: String {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
                return formatter.string(from: updatedAt)
            }
            
            var displayTitle: String {
                customTitle ?? "Chat" // Basit fallback
            }
        }

        struct MessageV2: Codable, Identifiable {
            var id: String
            let isFromCurrentUser: Bool
            let messageText: String
            var isTyping: Bool
            var imageData: [Data]?
            
            init(id: String = UUID().uuidString, isFromCurrentUser: Bool, messageText: String, isTyping: Bool = false, imageData: [Data]? = nil) {
                self.id = id
                self.isFromCurrentUser = isFromCurrentUser
                self.messageText = messageText
                self.isTyping = isTyping
                self.imageData = imageData
            }
        }
    }
}

// Migration Plan
enum ChatMigrationPlan: SchemaMigrationPlan {
    
    static var schemas: [any VersionedSchema.Type] {
        [ChatAppSchema.V1.self, ChatAppSchema.V2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: ChatAppSchema.V1.self,
        toVersion: ChatAppSchema.V2.self,
        willMigrate: nil,
        didMigrate: { context in
            let oldHistories = try context.fetch(FetchDescriptor<ChatAppSchema.V1.ChatHistoryV1>())
            
            for oldHistory in oldHistories {
                let newMessages: [ChatAppSchema.V2.MessageV2] = oldHistory.messages.map { oldMessage in
                    var newImageData: [Data]? = nil
                    if let oldData = oldMessage.imageData {
                        newImageData = [oldData]
                    }
                    
                    return ChatAppSchema.V2.MessageV2(
                        id: oldMessage.id,
                        isFromCurrentUser: oldMessage.isFromCurrentUser,
                        messageText: oldMessage.messageText,
                        isTyping: oldMessage.isTyping,
                        imageData: newImageData
                    )
                }
                
                let newHistory = ChatAppSchema.V2.ChatHistoryV2(
                    id: oldHistory.id,
                    chatbotType: oldHistory.chatbotType,
                    messages: newMessages,
                    createdAt: oldHistory.createdAt,
                    updatedAt: oldHistory.updatedAt,
                    customTitle: oldHistory.customTitle
                )
                
                context.insert(newHistory)
                context.delete(oldHistory)
            }
        }
    )
}
