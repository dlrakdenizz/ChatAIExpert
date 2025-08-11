//
//  HistoryCell.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import SwiftUI

struct HistoryCell: View {
    let history: ChatHistory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(Chatbots(rawValue: history.chatbotType)?.image ?? "dr.love")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(Chatbots(rawValue: history.chatbotType)?.title ?? "Unknown")
                        .font(.headline)
                    
                    Text(history.formattedDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            if let lastMessage = history.messages.last {
                Text(lastMessage.messageText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 8)
    }
}
