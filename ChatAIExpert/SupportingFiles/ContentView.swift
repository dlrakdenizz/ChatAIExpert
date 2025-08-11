//
//  ContentView.swift
//  ChatAIExpert
//
//  Created by Dilara Akdeniz on 31.07.2025.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("didSeeOnboarding") private var didSeeOnboarding: Bool = false
    @State private var showDailyGift = false
    @State private var isFirstLoginOfDay = false
    private let settingsRepository = SettingsRepository()
    
    var body: some View {
        ZStack {
            if didSeeOnboarding {
                TabBar()
                    .onAppear {
                        checkDailyLogin()
                    }
            } else {
                OnboardingMainScreen()
            }
            
            // Daily Gift Overlay
            if showDailyGift {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        // Prevent closing by tapping background
                    }
                
                VStack(spacing: 20) {
                    Text(NSLocalizedString("daily_gift", comment: ""))
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    GiftWithRibbonView {
                        claimDailyGift()
                    }
                }
                .padding(30)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.9))
                        .shadow(radius: 20)
                )
                .padding(40)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: showDailyGift)
    }
    
    private func checkDailyLogin() {
        let lastLoginDate = settingsRepository.getLastLoginDate()
        let currentDate = Date()
        
        // Eğer ilk giriş ise veya farklı bir gün ise
        if lastLoginDate == nil || !Calendar.current.isDate(lastLoginDate!, inSameDayAs: currentDate) {
            let currentCredits = settingsRepository.getQuestionCredits()
            
            // Eğer 5'ten az kredi varsa günlük hediye göster
            if currentCredits < 5 {
                isFirstLoginOfDay = true
                showDailyGift = true
            } else {
                // Sadece günlük kredi kontrolü yap, hediye gösterme
                settingsRepository.checkAndUpdateDailyCredits()
            }
        } else {
            // Aynı gün tekrar giriş, sadece kontrol yap
            settingsRepository.checkAndUpdateDailyCredits()
        }
    }
    
    private func claimDailyGift() {
        // Soru hakkını 5'e ayarla
        settingsRepository.setQuestionCredits(5)
        
        // Son giriş tarihini güncelle
        settingsRepository.setLastLoginDate(Date())
        
        // Animasyonu kapat
        withAnimation {
            showDailyGift = false
        }
        
        // Haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
}

#Preview {
    ContentView()
}
