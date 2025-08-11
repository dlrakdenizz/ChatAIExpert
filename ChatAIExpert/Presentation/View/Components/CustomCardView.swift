//
//  CustomCardView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import SwiftUI

struct CustomCardView: View {
    
    let chatbot: Chatbots
    @State private var isSaved: Bool = false
    @EnvironmentObject private var viewModel: ChatbotsViewModel
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10) {
            HStack {
                Spacer()
                Button(action: {
                    if isSaved {
                        SavedChatbotsManager.shared.unsaveChatbot(chatbot)
                        // If this was the last saved chatbot, switch to popular category
                        if SavedChatbotsManager.shared.getSavedChatbots().isEmpty {
                            viewModel.selectCategory(.popular)
                        } else if viewModel.selectedCategory == .saved {
                            // If we're in saved category, remove this chatbot from the view
                            viewModel.removeChatbot(chatbot)
                        }
                        HapticFeedbacks.soft()
                    } else {
                        SavedChatbotsManager.shared.saveChatbot(chatbot)
                        HapticFeedbacks.success()
                    }
                    isSaved.toggle()
                    NotificationCenter.default.post(name: NSNotification.Name("UpdateSavedChatbots"), object: nil)
                }) {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundColor(isSaved ? .blue : .gray)
                        .font(.system(size: 20))
                }
                .padding(.trailing, 8)
                .padding(.top, 8)
            }
            
            Image(chatbot.image)
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .clipShape(Circle())
                .shadow(radius: 4)
            
            Text(chatbot.title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Text(chatbot.description)
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
        .onAppear {
            isSaved = SavedChatbotsManager.shared.isChatbotSaved(chatbot)
        }
    }
}

#Preview {
    CustomCardView(chatbot: .scienceSage)
}
