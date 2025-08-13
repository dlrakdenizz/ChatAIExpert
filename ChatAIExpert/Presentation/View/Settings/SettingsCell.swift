//
//  SettingsCell.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import SwiftUI

struct SettingsCell: View {
    
    let item: SettingsItem
    let isLast: Bool
    let userSettings: UserSettings
    let onAction: (SettingsAction) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            cellContent
            
            if !isLast {
                Divider()
                    .padding(.leading, 52)
            }
        }
    }
    
    @ViewBuilder
    private var cellContent: some View {
        Button {
            onAction(item.action)
        } label: {
            HStack {
                iconView
                
                Text(item.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.horizontal, 12)
                
                Spacer()
                
                if let value = valueForAction(item.action) {
                    Text(value)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.trailing, 16)
                }
            }
            .padding(.vertical, 12)
            .background(Color.white)
        }
    }
    
    private var iconView: some View {
        ZStack {
            Circle()
                .fill(item.backgroundColor)
                .frame(width: SettingsUI.circleSize, height: SettingsUI.circleSize)
            
            Image(systemName: item.icon)
                .resizable()
                .frame(width: SettingsUI.iconSize, height: SettingsUI.iconSize)
                .foregroundStyle(item.foregroundColor)
        }
        .padding(.leading, 16)
    }
    
    private func valueForAction(_ action: SettingsAction) -> String? {
        switch action {
        default:
            return nil
        }
    }
}

// MARK: - UI Extensions and Constants

extension SettingsItem {
    private static let iconColorMap: [String: (background: Color, foreground: Color)] = [
        "calendar.badge.clock": (.orange.opacity(0.1), .orange),
        "creditcard.fill": (.green.opacity(0.1), .green),
        "globe": (.blue.opacity(0.1), .blue),
        "crown": (.yellow.opacity(0.1), .yellow),
        "arrow.clockwise": (.purple.opacity(0.1), .purple),
        "star": (.pink.opacity(0.1), .pink),
        "square.and.arrow.up": (.teal.opacity(0.1), .teal),
        "envelope.badge": (.red.opacity(0.1), .red),
        "hand.raised": (.mint.opacity(0.1), .mint),
        "doc.text": (.cyan.opacity(0.1), .cyan),
        "moon.circle.fill": (.indigo.opacity(0.1), .indigo),
        "questionmark.circle.fill": (.blue.opacity(0.1), .blue),
        "person.2" : (.purple.opacity(0.1), .purple)
    ]
    
    var backgroundColor: Color {
        Self.iconColorMap[icon]?.background ?? .gray.opacity(0.1)
    }
    
    var foregroundColor: Color {
        Self.iconColorMap[icon]?.foreground ?? .gray
    }
}

struct SettingsUI {
    static let iconSize: CGFloat = 20
    static let circleSize: CGFloat = 36
    static let cornerRadius: CGFloat = 12
    static let sectionSpacing: CGFloat = 24
    static let shadowRadius: CGFloat = 5
    static let shadowOpacity: Double = 0.05
}

struct SettingsConstants {
    static let appName = "ChatAI"
    static let copyrightText = "© 2025 ChatAI. All rights reserved."
}

struct AppVersionInfoView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text(SettingsConstants.appName)
                .font(.system(size: 16, weight: .bold))
            
            Text(getVersionInfo())
                .font(.system(size: 14))
            
            Text(SettingsConstants.copyrightText)
                .font(.system(size: 12))
        }
        .foregroundColor(.gray)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
    }
    
    private func getVersionInfo() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "Version \(version) - Build \(build)"
    }
}

        
