//
//  HistoryViewModel.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class HistoryViewModel {
    static let shared = HistoryViewModel()
    var chatHistories: [ChatHistory] = []
    private let modelContext: ModelContext
    
    private init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            let container = try ModelContainer(for: ChatHistory.self, configurations: config)
            modelContext = ModelContext(container)
            loadHistories()
        } catch {
            fatalError("Could not initialize SwiftData: \(error)")
        }
    }
    
    private func loadHistories() {
        let descriptor = FetchDescriptor<ChatHistory>(sortBy: [SortDescriptor(\.updatedAt, order: .reverse)])
        do {
            chatHistories = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching histories: \(error)")
        }
    }
    
    func saveHistory(_ history: ChatHistory) {
        if let existingHistory = chatHistories.first(where: { $0.id == history.id }) {
            modelContext.delete(existingHistory)
        }
        modelContext.insert(history)
        do {
            try modelContext.save()
            loadHistories()
        } catch {
            print("Error saving history: \(error)")
        }
    }
    
    func deleteHistory(at indexSet: IndexSet) {
        for index in indexSet {
            let history = chatHistories[index]
            modelContext.delete(history)
        }
        do {
            try modelContext.save()
            loadHistories()
        } catch {
            print("Error deleting history: \(error)")
        }
    }
    
    func clearAllHistories() {
        for history in chatHistories {
            modelContext.delete(history)
        }
        do {
            try modelContext.save()
            chatHistories.removeAll()
        } catch {
            print("Error clearing histories: \(error)")
        }
    }
}

