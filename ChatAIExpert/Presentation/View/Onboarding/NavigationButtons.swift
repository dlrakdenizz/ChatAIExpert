//
//  NavigationButtons.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 30.07.2025.
//

import SwiftUI

struct NavigationButtons: View {
    @Binding var currentPage: Int
    let totalPages: Int
    let accentColor: Color
    let onComplete: () -> Void

    @State private var arrowOffset: CGFloat = -3
    @State private var arrowOpacity: Double = 0.7
    @State private var buttonScale: CGFloat = 1.0
    
    // Responsive design helpers
    private var isSmallScreen: Bool {
        UIScreen.main.bounds.width <= 375
    }
    
    private var isMediumScreen: Bool {
        UIScreen.main.bounds.width > 375 && UIScreen.main.bounds.width <= 430
    }
    
    private var buttonSpacing: CGFloat {
        if isSmallScreen {
            return 20
        } else if isMediumScreen {
            return 22
        } else {
            return 25
        }
    }
    
    private var skipButtonFontSize: CGFloat {
        if isSmallScreen {
            return 14
        } else if isMediumScreen {
            return 15
        } else {
            return 16
        }
    }
    
    private var nextButtonFontSize: CGFloat {
        if isSmallScreen {
            return 14
        } else if isMediumScreen {
            return 15
        } else {
            return 16
        }
    }
    
    private var getStartedFontSize: CGFloat {
        if isSmallScreen {
            return 16
        } else if isMediumScreen {
            return 17
        } else {
            return 18
        }
    }
    
    private var nextButtonWidth: CGFloat {
        if isSmallScreen {
            return 100
        } else if isMediumScreen {
            return 110
        } else {
            return 120
        }
    }
    
    private var nextButtonHeight: CGFloat {
        if isSmallScreen {
            return 45
        } else if isMediumScreen {
            return 48
        } else {
            return 50
        }
    }
    
    private var getStartedButtonWidth: CGFloat {
        if isSmallScreen {
            return 180
        } else if isMediumScreen {
            return 190
        } else {
            return 200
        }
    }
    
    private var getStartedButtonHeight: CGFloat {
        if isSmallScreen {
            return 50
        } else if isMediumScreen {
            return 52
        } else {
            return 55
        }
    }
    
    private var horizontalPadding: CGFloat {
        if isSmallScreen {
            return 25
        } else if isMediumScreen {
            return 28
        } else {
            return 32
        }
    }

    var body: some View {
        HStack(spacing: buttonSpacing) {
            if currentPage < totalPages - 1 {
                Button(localized("Skip")) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        currentPage = totalPages - 1
                    }
                }
                .font(.system(size: skipButtonFontSize, weight: .medium))
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.gray.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                )

                Button {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        currentPage += 1
                    }
                } label: {
                    HStack(spacing: 8) {
                        Text(localized("Next"))
                            .font(.system(size: nextButtonFontSize, weight: .semibold))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14, weight: .bold))
                            .offset(x: arrowOffset)
                            .opacity(arrowOpacity)
                    }
                    .foregroundColor(.white)
                    .frame(width: nextButtonWidth, height: nextButtonHeight)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        accentColor,
                                        accentColor.opacity(0.8)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: accentColor.opacity(0.4), radius: 15, x: 0, y: 8)
                    )
                    .scaleEffect(buttonScale)
                }
                .onAppear {
                    withAnimation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true)
                    ) {
                        arrowOffset = 3
                        arrowOpacity = 1
                    }
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        buttonScale = 0.95
                    }
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6).delay(0.1)) {
                        buttonScale = 1.0
                    }
                }
            } else {
                Button {
                    onComplete()
                } label: {
                    HStack(spacing: 8) {
                        Text(localized("Get Started"))
                            .font(.system(size: getStartedFontSize, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .frame(width: getStartedButtonWidth, height: getStartedButtonHeight)
                    .background(
                        RoundedRectangle(cornerRadius: 28)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        accentColor,
                                        accentColor.opacity(0.7)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: accentColor.opacity(0.5), radius: 20, x: 0, y: 10)
                    )
                    .scaleEffect(buttonScale)
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        buttonScale = 0.95
                    }
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6).delay(0.1)) {
                        buttonScale = 1.0
                    }
                }
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
}

