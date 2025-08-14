//
//  SettingsView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel: SettingsViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: DIContainer.shared.makeSettingsViewModel())
    }
    
    var body: some View {
        NavigationStack {
            ZStack {

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(SettingsSection.allCases, id: \.self) { section in
                            buildSectionView(for: section)
                        }
                        
                        
                        AppVersionInfoView()
                            .padding(.top, 36)
                    }
                }
                .background(Color(.systemGray6))
               
                // Toast overlay
                if viewModel.showToast {
                    VStack {
                        Spacer()
                        ToastView(message: viewModel.toastMessage)
                            .padding(.bottom, 100)
                    }
                    .animation(.easeInOut, value: viewModel.showToast)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(localized("settings"))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            .sheet(isPresented: $viewModel.showLanguageSelection) {
                LanguageSelectionView()
            }
        }
    }
    
    @ViewBuilder
    private func buildSectionView(for section: SettingsSection) -> some View {
        let items = viewModel.items[section] ?? []
        
        if !items.isEmpty {
            SettingsSectionView(
                section: section,
                items: items,
                userSettings: viewModel.userSettings,
                onAction: viewModel.handle
            )
        }
    }
}

#Preview {
    SettingsView()
}
