//
//  SettingsSectionView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import SwiftUI

struct SettingsSectionView: View {
    
    let section: SettingsSection
    let items: [SettingsItem]
    let userSettings: UserSettings
    let onAction: (SettingsAction) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionHeader
            itemsList
        }
    }
    
    private var sectionHeader: some View {
        Text(section.rawValue)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.black)
            .padding(.top, SettingsUI.sectionSpacing)
            .padding(.bottom, 12)
            .padding(.horizontal)
    }
    
    private var itemsList: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                SettingsCell(
                    item: item,
                    isLast: index == items.count - 1,
                    userSettings: userSettings,
                    onAction: onAction
                )
            }
        }
        .background(Color.white)
        .cornerRadius(SettingsUI.cornerRadius)
        .shadow(
            color: Color.black.opacity(SettingsUI.shadowOpacity),
            radius: SettingsUI.shadowRadius,
            x: 0,
            y: 2
        )
        .padding(.horizontal)
    }
}

