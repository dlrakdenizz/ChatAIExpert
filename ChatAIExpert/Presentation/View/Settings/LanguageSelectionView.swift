//
//  LanguageSelectionView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import SwiftUI

struct LanguageSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var languageManager = LanguageManager.shared
    @State private var showingLanguageChangeAlert = false
    @State private var selectedLanguageToChange: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // Handle bar
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color(.systemGray4))
                .frame(width: 36, height: 5)
                .padding(.top, 8)
                .padding(.bottom, 16)
            
            // Title
            Text(NSLocalizedString("Select Language", comment: ""))
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 8)
            
            // Info text
            Text(NSLocalizedString("language_change_info", comment: ""))
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            
            // Language options
            VStack(spacing: 0) {
                ForEach(Array(languageManager.getSupportedLanguages().enumerated()), id: \.offset) { index, language in
                    LanguageOptionRow(
                        flag: language.flag,
                        language: language.name,
                        isSelected: languageManager.currentLanguage == language.code,
                        onTap: {
                            selectedLanguageToChange = language.code
                            showingLanguageChangeAlert = true
                        }
                    )
                    
                    if index < languageManager.getSupportedLanguages().count - 1 {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .presentationDetents([.height(400)]) // Increased height to accommodate more languages
        .presentationDragIndicator(.hidden)
        .alert(NSLocalizedString("Change Language", comment: ""), isPresented: $showingLanguageChangeAlert) {
            Button(NSLocalizedString("Cancel", comment: ""), role: .cancel) { }
            Button(NSLocalizedString("Change", comment: "")) {
                languageManager.changeLanguage(to: selectedLanguageToChange)
            }
        } message: {
            Text(NSLocalizedString("language_change_restart_message", comment: ""))
        }
    }
}

struct LanguageOptionRow: View {
    let flag: String
    let language: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
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
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    LanguageSelectionView()
}
