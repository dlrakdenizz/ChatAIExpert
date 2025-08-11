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
            title:  "Unlock Your World of Knowledge",
            description: "Welcome to your personal hub for discovery and growth. Your advanced AI companions are ready to guide you.",
            accentColor: Color(hex: "6366F1"), // Indigo
            rotation: 15
        ),
        OnboardingItem(
            image: "astro_agent",
            title: "Instant Answers,\nEndless Possibilities",
            description: "Get quick, reliable responses and expert advice whenever you need it. Chat instantly, learn effortlessly.",
            accentColor: Color(hex: "3B82F6"), // Blue
            rotation: -10
        ),
        OnboardingItem(
            image: "flirty",
            title: "Your Personal Expert in Every Field",
            description: " From health to relationships, education to language, find a dedicated AI partner. Achieve more, effortlessly.",
            accentColor: Color(hex: "EF4444"), // Purple
            rotation: 8
        ),
        OnboardingItem(
            image: "splash_foto",
            title: "Ready to Start Your Journey?",
            description: "Tap below to explore our diverse AI companions and start your personalized journey today.",
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
