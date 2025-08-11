//
//  ChatBubble.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 15.07.2025.
//

import SwiftUI

struct ChatBubble: Shape {
    
    var isFromCurrentUser : Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, isFromCurrentUser ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
    
}

#Preview {
    ChatBubble(isFromCurrentUser: true)
}
