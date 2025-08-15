//
//  HistoryViewModel.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import Foundation
import SwiftUI
import SwiftData

typealias ChatHistory = ChatAppSchema.V2.ChatHistoryV2
typealias Message = ChatAppSchema.V2.MessageV2

@Observable
class HistoryViewModel {
    static let shared = HistoryViewModel()
    var chatHistories: [ChatHistory] = []
    private let modelContext: ModelContext
    private var isLoaded = false
    
    private init() {
            print("🚀 Initializing HistoryViewModel...")
            do {
                // Migration planı ile container oluştur
                let container = try ModelContainer(
                    migrationPlan: ChatMigrationPlan.self
                )
                modelContext = ModelContext(container)
                print("✅ SwiftData container created successfully")
                
                // Biraz delay vererek migration'ın tamamlanmasını bekle
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.loadHistories()
                }
            } catch {
                print("❌ SwiftData initialization error: \(error)")
                // Fallback - eğer migration başarısız olursa basit container oluştur
                do {
                    let fallbackContainer = try ModelContainer(for: ChatAppSchema.V2.ChatHistoryV2.self)
                    modelContext = ModelContext(fallbackContainer)
                    print("✅ Fallback container created")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.loadHistories()
                    }
                } catch {
                    print("💥 Fatal: Could not initialize SwiftData: \(error)")
                    fatalError("Could not initialize SwiftData: \(error)")
                }
            }
        }
    
    func ensureLoaded() {
            guard !isLoaded else { return }
            print("🔄 Ensuring data is loaded...")
            loadHistories()
        }
        
    
    private func loadHistories() {
            print("📂 Loading histories from SwiftData...")
            
            // Migration tamamlanmış mı kontrol et
            let descriptor = FetchDescriptor<ChatHistory>(sortBy: [SortDescriptor(\.updatedAt, order: .reverse)])
            
            do {
                let fetchedHistories = try modelContext.fetch(descriptor)
                print("📊 Fetched \(fetchedHistories.count) chat histories from database")
                
                // Ana thread'de UI güncellemesi yap
                DispatchQueue.main.async { [weak self] in
                    self?.chatHistories = fetchedHistories
                    self?.isLoaded = true
                    print("✅ UI updated with \(fetchedHistories.count) histories")
                    
                    // Debug: Her history'nin detaylarını logla
                    for (index, history) in fetchedHistories.enumerated() {
                        print("  📝 History \(index + 1): ID=\(history.id.prefix(8))..., Messages=\(history.messages.count), Bot=\(history.chatbotType)")
                    }
                }
            } catch {
                print("❌ Error fetching histories: \(error)")
                print("🔍 Error details: \(error.localizedDescription)")
                
                DispatchQueue.main.async { [weak self] in
                    self?.chatHistories = []
                    self?.isLoaded = true
                }
            }
        }
        
    
    func saveHistory(_ history: ChatHistory) {
           print("💾 Attempting to save history...")
           print("  📋 History ID: \(history.id.prefix(8))...")
           print("  🤖 Chatbot: \(history.chatbotType)")
           print("  💬 Messages count: \(history.messages.count)")
           
           // Existing history kontrolü
           if let existingIndex = chatHistories.firstIndex(where: { $0.id == history.id }) {
               print("🔄 Found existing history at index \(existingIndex), updating...")
               let existingHistory = chatHistories[existingIndex]
               modelContext.delete(existingHistory)
           } else {
               print("🆕 This is a new history entry")
           }
           
           // Insert new history
           modelContext.insert(history)
           print("➕ History inserted into context")
           
           do {
               try modelContext.save()
               print("✅ History successfully saved to SwiftData!")
               
               // UI'ı main thread'de güncelle
               DispatchQueue.main.async { [weak self] in
                   self?.loadHistories()
               }
           } catch {
               print("❌ ERROR saving history: \(error)")
               print("🔍 Error details: \(error.localizedDescription)")
               
               // Context durumunu kontrol et
               if modelContext.hasChanges {
                   print("⚠️ Context still has unsaved changes, rolling back...")
                   modelContext.rollback()
               }
           }
       }
    
    func deleteHistory(at indexSet: IndexSet) {
            print("🗑️ Deleting histories at indices: \(Array(indexSet))")
            for index in indexSet {
                let history = chatHistories[index]
                print("🗑️ Deleting history with ID: \(history.id.prefix(8))...")
                modelContext.delete(history)
            }
            do {
                try modelContext.save()
                print("✅ Histories successfully deleted")
                loadHistories()
            } catch {
                print("❌ Error deleting history: \(error)")
                modelContext.rollback()
            }
        }
    
    func clearAllHistories() {
           print("🧹 Clearing all \(chatHistories.count) histories")
           for history in chatHistories {
               modelContext.delete(history)
           }
           do {
               try modelContext.save()
               print("✅ All histories cleared successfully")
               DispatchQueue.main.async { [weak self] in
                   self?.chatHistories.removeAll()
               }
           } catch {
               print("❌ Error clearing histories: \(error)")
               modelContext.rollback()
           }
       }
       
       // Manuel refresh fonksiyonu
       func refreshHistories() {
           print("🔄 Manual refresh requested")
           isLoaded = false
           loadHistories()
       }
}

