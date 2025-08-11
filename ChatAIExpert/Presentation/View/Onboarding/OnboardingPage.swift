//
//  OnboardingPage.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 30.07.2025.
//

import SwiftUI

struct OnboardingPage: View {
    let item: OnboardingItem
    let screenWidth: CGFloat
    var isLastPage: Bool
    
    @State private var isAnimating = false
    @State private var imageScale: CGFloat = 1.1
    @State private var imageOffset: CGFloat = -30
    @State private var imageRotation: Double = 8
    @State private var textOpacity: Double = 0
    @State private var textOffset: CGFloat = 40
    @State private var shadowRadius: CGFloat = 0
    
    // Responsive design helpers
    private var isSmallScreen: Bool {
        screenWidth <= 375 // iPhone XS, SE, etc.
    }
    
    private var isMediumScreen: Bool {
        screenWidth > 375 && screenWidth <= 430 // iPhone 14 Pro, 15 Pro, etc.
    }
    
    private var titleFontSize: CGFloat {
        if isSmallScreen {
            return 22
        } else if isMediumScreen {
            return 26
        } else {
            return 28
        }
    }
    
    private var descriptionFontSize: CGFloat {
        if isSmallScreen {
            return 14
        } else if isMediumScreen {
            return 16
        } else {
            return 17
        }
    }
    
    private var imageContainerWidth: CGFloat {
        if isSmallScreen {
            return 0.9
        } else if isMediumScreen {
            return 0.85
        } else {
            return 0.8
        }
    }
    
    private var imageContainerHeight: CGFloat {
        if isSmallScreen {
            return 0.35
        } else if isMediumScreen {
            return 0.38
        } else {
            return 0.4
        }
    }
    
    private var imageWidth: CGFloat {
        if isSmallScreen {
            return 0.65
        } else if isMediumScreen {
            return 0.62
        } else {
            return 0.6
        }
    }
    
    private var imageHeight: CGFloat {
        if isSmallScreen {
            return 0.25
        } else if isMediumScreen {
            return 0.28
        } else {
            return 0.3
        }
    }
    
    private var verticalSpacing: CGFloat {
        if isSmallScreen {
            return 30
        } else if isMediumScreen {
            return 40
        } else {
            return 50
        }
    }
    
    private var textSpacing: CGFloat {
        if isSmallScreen {
            return 15
        } else if isMediumScreen {
            return 18
        } else {
            return 20
        }
    }
    
    private var horizontalPadding: CGFloat {
        if isSmallScreen {
            return 30
        } else if isMediumScreen {
            return 35
        } else {
            return 40
        }
    }
    
    private var bottomSpacing: CGFloat {
        if isSmallScreen {
            return 80
        } else if isMediumScreen {
            return 100
        } else {
            return 120
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: verticalSpacing) {
                ZStack {
                    // Shadow behind image
                    RoundedRectangle(cornerRadius: 30)
                        .fill(item.accentColor.opacity(0.1))
                        .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.45)
                        .blur(radius: shadowRadius)
                        .offset(y: 8)
                    
                    // Main image container
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    item.accentColor.opacity(0.05),
                                    .white,
                                    item.accentColor.opacity(0.08)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: geometry.size.width * imageContainerWidth, height: geometry.size.height * imageContainerHeight)
                        .shadow(color: item.accentColor.opacity(0.2), radius: 20, x: 0, y: 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            item.accentColor.opacity(0.3),
                                            .clear,
                                            item.accentColor.opacity(0.2)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                        .overlay(
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * imageWidth, height: geometry.size.height * imageHeight)
                                .scaleEffect(imageScale)
                                .rotationEffect(.degrees(imageRotation))
                        )
                }
                .frame(height: geometry.size.height * 0.5)
                
                VStack(spacing: textSpacing) {
                    Text(item.title)
                        .font(.system(size: titleFontSize, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black,
                                    item.accentColor.opacity(0.8)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .multilineTextAlignment(.center)
                        .lineLimit(isSmallScreen ? 3 : isMediumScreen ? 4 : 2)
                        .opacity(textOpacity)
                        .offset(y: textOffset)
                    
                    Text(item.description)
                        .font(.system(size: descriptionFontSize, weight: .medium))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, horizontalPadding)
                        .lineSpacing(isSmallScreen ? 3 : isMediumScreen ? 3.5 : 4)
                        .opacity(textOpacity)
                        .offset(y: textOffset)
                }
                .padding(.top, isSmallScreen ? 5 : isMediumScreen ? 8 : 10)
                
                Spacer()
                    .frame(height: bottomSpacing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                withAnimation(.spring(response: 1.0, dampingFraction: 0.7).delay(0.2)) {
                    imageScale = 1.0
                    imageOffset = 0
                    imageRotation = 0
                    shadowRadius = 10
                }
                
                withAnimation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.4)) {
                    textOpacity = 1
                    textOffset = 0
                }
                
                withAnimation(
                    .easeInOut(duration: 3)
                    .repeatForever(autoreverses: true)
                ) {
                    imageScale = 1.05
                    imageOffset = -5
                }
            }
            .id(item.image) // Her sayfa için unique ID
            .onChange(of: item.image) { _ in
                // Reset animations
                imageScale = 1.1
                imageOffset = -30
                imageRotation = 8
                textOpacity = 0
                textOffset = 40
                shadowRadius = 0
                
                // Trigger animations
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 1.0, dampingFraction: 0.7)) {
                        imageScale = 1.0
                        imageOffset = 0
                        imageRotation = 0
                        shadowRadius = 10
                    }
                    
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.4)) {
                        textOpacity = 1
                        textOffset = 0
                    }
                    
                    // Sürekli animasyon
                    withAnimation(
                        .easeInOut(duration: 3)
                        .repeatForever(autoreverses: true)
                    ) {
                        imageScale = 1.05
                        imageOffset = -5
                    }
                }
            }
        }
    }
}
