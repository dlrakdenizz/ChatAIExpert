//
//  ToastView.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 31.05.2025.
//

import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
            
            Text(message)
                .font(.system(size: 14, weight: .medium))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.black.opacity(0.9))
        .foregroundColor(.white)
        .cornerRadius(12)
        .shadow(radius: 8, x: 0, y: 4)
    }
}


