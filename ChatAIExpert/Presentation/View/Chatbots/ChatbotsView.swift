//
//  ChatbotsView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import SwiftUI

struct ChatbotsView: View {
    @StateObject private var viewModel: ChatbotsViewModel
    @State private var hasSavedChatbots: Bool = false // "Saved" kategorisi gösterilmeli mi kontrol eder.
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    init() {
        self._viewModel = StateObject(wrappedValue: DIContainer.shared.makeChatbotsViewModel())
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(ChatbotCategory.allCases.filter { category in
                        category != .saved || hasSavedChatbots
                    }) { category in
                        Button(action: {
                            viewModel.selectCategory(category)
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: category.iconName)
                                    .font(.system(size: 18))
                                Text(category.localizedName)
                                    .font(.system(size: 18))
                            }
                            .foregroundColor(viewModel.selectedCategory == category ? .white : .black)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 18)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(viewModel.selectedCategory == category ? Color.accentColor : Color(.systemGray6))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(viewModel.selectedCategory == category ? Color.accentColor : Color(.systemGray4), lineWidth: 1)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 4)
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.chatbots, id: \.self) { chatbot in
                        NavigationLink(destination: ChatView(chatbot: chatbot), label: {
                            CustomCardView(chatbot: chatbot)
                        })
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 5)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        //View açıldığında veya kayıtlı chatbot listesi güncellendiğinde hasSavedChatbots güncellenir.
        .onAppear {
            checkSavedChatbots()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("UpdateSavedChatbots"))) { _ in
            checkSavedChatbots()
        }
        .environmentObject(viewModel)
    }
    
    //SavedChatbotsManager ile kayıtlı chatbot olup olmadığını kontrol eder.
    private func checkSavedChatbots() {
        hasSavedChatbots = !SavedChatbotsManager.shared.getSavedChatbots().isEmpty
    }
}

#Preview {
    ChatbotsView()
}
