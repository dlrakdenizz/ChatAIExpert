//
//  MessageView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 15.07.2025.
//

import SwiftUI

struct MessageView: View {
    
    var isFromCurrentUser : Bool
    var messageText : String
    let chatbot : Chatbots
    var isTyping: Bool = false
    var paragraphs: [String] = []
    var imageData: Data?
    @State private var dotOffset: CGFloat = 0
    @State private var showingCopyAlert = false
    
    var body: some View {
        HStack{
            if isFromCurrentUser {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 200)
                            .cornerRadius(10)
                    }
                    
                    if !messageText.isEmpty {
                        Text(messageText)
                            .padding(12)
                            .background(Color.black)
                            .font(.system(size: 15))
                            .clipShape(ChatBubble(isFromCurrentUser: true))
                            .foregroundStyle(Color.white)
                            .onLongPressGesture {
                                copyMessageToClipboard()
                            }
                            .scaleEffect(showingCopyAlert ? 0.95 : 1.0)
                            .animation(.easeInOut(duration: 0.1), value: showingCopyAlert)
                    }
                }
                .padding(.leading, 100)
                .padding(.horizontal)
            } else {
                HStack {
                    Image(chatbot.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    if isTyping {
                        HStack(spacing: 4) {
                            ForEach(0..<3) { index in
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 8, height: 8)
                                    .offset(y: dotOffset)
                                    .animation(
                                        Animation.easeInOut(duration: 0.5)
                                            .repeatForever()
                                            .delay(0.2 * Double(index)),
                                        value: dotOffset
                                    )
                            }
                        }
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(ChatBubble(isFromCurrentUser: false))
                        .onAppear {
                            dotOffset = -5
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 200)
                                    .cornerRadius(10)
                            }
                            
                            Text(messageText)
                                .padding(12)
                                .background(Color(.systemGray6))
                                .font(.system(size: 16))
                                .clipShape(ChatBubble(isFromCurrentUser: false))
                                .foregroundStyle(Color.black)
                                .onLongPressGesture {
                                    copyMessageToClipboard()
                                }
                                .scaleEffect(showingCopyAlert ? 0.95 : 1.0)
                                .animation(.easeInOut(duration: 0.1), value: showingCopyAlert)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.trailing, 80)
                
                Spacer()
            }
        }
        .overlay(
            Group {
                if showingCopyAlert {
                    VStack {
                        Spacer()
                        ToastView(message: "Mesaj kopyalandı")
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        showingCopyAlert = false
                                    }
                                }
                            }
                    }
                    .padding(.bottom, 120)
                }
            }
        )
    }
    
    private func copyMessageToClipboard() {
        guard !messageText.isEmpty else { return }
        
        UIPasteboard.general.string = messageText
        HapticFeedbacks.success()
        
        withAnimation(.easeInOut(duration: 0.3)) {
            showingCopyAlert = true
        }
    }
}

