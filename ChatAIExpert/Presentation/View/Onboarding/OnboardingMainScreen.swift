//
//  OnboardingMainScreen.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 30.07.2025.
//

import SwiftUI

struct OnboardingMainScreen: View {
    
    @AppStorage("didSeeOnboarding") private var didSeeOnboarding: Bool = false
    @State private var currentPage = 0
    @State private var dragOffset: CGSize = .zero
    
    let onboardingData = [
        OnboardingItem(
            image: "dr_love",
            title:  localized("onboarding_1_title"),
            description: localized("onboarding_1_message"),
            accentColor: Color(hex: "6366F1"), // Indigo
            rotation: 15
        ),
        OnboardingItem(
            image: "astro_agent",
            title: localized("onboarding_2_title"),
            description: localized("onboarding_2_message"),
            accentColor: Color(hex: "3B82F6"), // Blue
            rotation: -10
        ),
        OnboardingItem(
            image: "flirty",
            title: localized("onboarding_3_title"),
            description: localized("onboarding_3_message"),
            accentColor: Color(hex: "EF4444"), // Purple
            rotation: 8
        ),
        OnboardingItem(
            image: "splash_foto",
            title: localized("onboarding_4_title"),
            description: localized("onboarding_4_message"),
            accentColor: Color(hex: "EC4899"), // Pink
            rotation: -12
        )
    ]
    
    var body: some View {
        GeometryReader { geometry in
            let isSmallScreen = geometry.size.width <= 375
            let isMediumScreen = geometry.size.width > 375 && geometry.size.width <= 430
            
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white,
                        Color(hex: "F8FAFC"),
                        Color.white
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Subtle animated particles
                FloatingShapesView(accentColor: onboardingData[currentPage].accentColor)
                    .opacity(0.3)
                
                TabView(selection: $currentPage) {
                    ForEach(0..<onboardingData.count, id: \.self) { index in
                        OnboardingPage(
                            item: onboardingData[index],
                            screenWidth: geometry.size.width,
                            isLastPage: index == onboardingData.count - 1
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                VStack {
                    Spacer()
                    
                    PageIndicator(
                        totalPages: onboardingData.count,
                        currentPage: currentPage,
                        accentColor: onboardingData[currentPage].accentColor
                    )
                    .padding(.bottom, isSmallScreen ? 20 : isMediumScreen ? 22 : 25)
                    
                    NavigationButtons(
                        currentPage: $currentPage,
                        totalPages: onboardingData.count,
                        accentColor: onboardingData[currentPage].accentColor,
                        onComplete: {
                            didSeeOnboarding = true
                        }
                    )
                }
                .padding(.bottom, geometry.safeAreaInsets.bottom + (isSmallScreen ? 10 : isMediumScreen ? 12 : 15))
            }
        }
    }
}
