//
//  LanguageSelectionView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import SwiftUI

struct LanguageSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Handle bar
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color(.systemGray4))
                .frame(width: 36, height: 5)
                .padding(.top, 8)
                .padding(.bottom, 16)
            
            // Title
            Text("Select Language")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 24)
            
            // Language options
            VStack(spacing: 0) {
                LanguageOptionRow(
                    flag: "🇺🇸",
                    language: "English",
                    isSelected: true
                )
                
                Divider()
                    .padding(.horizontal, 20)
                
                LanguageOptionRow(
                    flag: "🇹🇷",
                    language: "Türkçe",
                    isSelected: false
                )
            }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .presentationDetents([.height(200)])
        .presentationDragIndicator(.hidden)
    }
}

struct LanguageOptionRow: View {
    let flag: String
    let language: String
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Text(flag)
                .font(.system(size: 28))
            
            Text(language)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.black)
            
            Spacer()
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 22))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.white)
        .contentShape(Rectangle())
    }
}

#Preview {
    LanguageSelectionView()
}
