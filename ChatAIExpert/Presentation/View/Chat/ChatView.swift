//
//  ChatView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 15.07.2025.
//

import SwiftUI

struct ChatView: View {
    
    let chatbot: Chatbots
    let historyId: String?
    @State private var messageText = ""
    @State private var selectedImage: UIImage?
    @StateObject private var viewModel: ChatViewModel
    @StateObject private var keyboardManager = KeyboardManager()
    
    @State private var showCreditsAlert = false
    @State private var creditsAlertMessage = ""
    @State private var showNewChatConfirmation = false
    
    private let settingsRepository = SettingsRepository()
    
    @State private var isShareSheetPresented = false
    
    init(chatbot: Chatbots, historyId: String? = nil) {
        self.chatbot = chatbot
        self.historyId = historyId
        _viewModel = StateObject(wrappedValue: DIContainer.shared.makeChatViewModel(
            chatbotType: chatbot,
            historyId: historyId
        ))
    }
    
    var body: some View {
        
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 12){
                    ForEach(viewModel.messages) { message in
                        MessageView(
                            isFromCurrentUser: message.isFromCurrentUser,
                            messageText: message.messageText,
                            chatbot: chatbot,
                            isTyping: message.isTyping,
                            imageData: message.imageData
                        )
                        .id(message.id)
                    }
                }
            }
            .onAppear {
                if let lastMessage = viewModel.messages.last {
                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                }
            }
            .onChange(of: viewModel.messages.count) { _ in
                if let lastMessage = viewModel.messages.last {
                    withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            .onTapGesture {
                keyboardManager.dismissKeyboard()
            }
            CustomInputChatView(
                text: $messageText,
                action: sendMessage,
                chatbot: chatbot,
                selectedImage : $selectedImage,
                viewModel: viewModel
            )
            .padding(.bottom, 10)
            .navigationTitle(chatbot.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button(action: {
                            viewModel.prepareShareText()
                            isShareSheetPresented = true
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            showNewChatConfirmation = true
                        }) {
                            Image(systemName: "square.and.pencil")
                                .foregroundColor(viewModel.isResponding ? .gray : .black)
                        }
                        .disabled(viewModel.isResponding)
                    }
                }
            }
            .padding(.vertical)
            .onDisappear {
                if historyId == nil {
                    viewModel.clearMessages()
                }
            }
            .sheet(isPresented: $isShareSheetPresented) {
                ShareSheet(activityItems: [viewModel.shareText])
            }
            .alert("Question Credit!", isPresented: $showCreditsAlert) {
                Button("OK") { }
            } message: {
                Text(creditsAlertMessage)
            }
            .alert("New Chat", isPresented: $showNewChatConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("OK") {
                    viewModel.clearMessages()
                }
            } message: {
                Text("A new chat will be opened and your current chat will be saved to history. Do you want to continue?")
            }
        }
    }
    
    func sendMessage() {
        let currentCredits = settingsRepository.getQuestionCredits()
                
        if currentCredits <= 0 {
            creditsAlertMessage = "You have used up your question limit! Please try again tomorrow!"
            showCreditsAlert = true
            return
        }
        
        if let image = selectedImage {
            viewModel.sendMessage(messageText, image: image)
            selectedImage = nil
        } else {
            viewModel.sendMessage(messageText)
        }
        messageText = ""
    }
}

#Preview {
    ChatView(chatbot: .drLove)
}
