//
//  HistoryView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import SwiftUI

struct HistoryView: View {
    @State private var viewModel = HistoryViewModel.shared
    @State private var showDeleteConfirmation = false
    @State private var showClearAllConfirmation = false
    @State private var indexSetToDelete: IndexSet?
    
    var body: some View {
        List {
            ForEach(viewModel.chatHistories) { history in
                NavigationLink(destination: ChatView(chatbot: Chatbots(rawValue: history.chatbotType) ?? .drLove, historyId: history.id)) {
                    HistoryCell(history: history)
                }
            }
            .onDelete { indexSet in
                indexSetToDelete = indexSet
                showDeleteConfirmation = true
            }
        }
        .listStyle(.plain)
        .overlay {
            if viewModel.chatHistories.isEmpty {
                ContentUnavailableView(
                    localized("no_chat_history"),
                    systemImage: "clock.arrow.circlepath",
                    description: Text(localized("no_chat_message"))
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if !viewModel.chatHistories.isEmpty {
                    Button(action: {
                        showClearAllConfirmation = true
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .alert("Delete Chat", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let indexSet = indexSetToDelete {
                    viewModel.deleteHistory(at: indexSet)
                }
            }
        } message: {
            Text("Are you sure you want to delete this chat? This action cannot be undone.")
        }
        .alert(localized("clear_chat_title"), isPresented: $showClearAllConfirmation) {
            Button(localized("Cancel"), role: .cancel) { }
            Button(localized("clear_all"), role: .destructive) {
                viewModel.clearAllHistories()
            }
        } message: {
            Text(localized("clear_chat_message"))
        }
    }
}


#Preview {
    HistoryView()
}
