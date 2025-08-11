//
//  PageIndicator.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 30.07.2025.
//

import SwiftUI

struct PageIndicator: View {
    let totalPages: Int
    let currentPage: Int
    let accentColor: Color
    
    // Responsive design helpers
    private var isSmallScreen: Bool {
        UIScreen.main.bounds.width <= 375
    }
    
    private var isMediumScreen: Bool {
        UIScreen.main.bounds.width > 375 && UIScreen.main.bounds.width <= 430
    }
    
    private var activeDotWidth: CGFloat {
        if isSmallScreen {
            return 20
        } else if isMediumScreen {
            return 22
        } else {
            return 25
        }
    }
    
    private var activeDotHeight: CGFloat {
        if isSmallScreen {
            return 6
        } else if isMediumScreen {
            return 7
        } else {
            return 8
        }
    }
    
    private var inactiveDotSize: CGFloat {
        if isSmallScreen {
            return 6
        } else if isMediumScreen {
            return 7
        } else {
            return 8
        }
    }
    
    private var dotSpacing: CGFloat {
        if isSmallScreen {
            return 8
        } else if isMediumScreen {
            return 9
        } else {
            return 10
        }
    }

    var body: some View {
        HStack(spacing: dotSpacing) {
            ForEach(0..<totalPages, id: \.self) { index in
                if currentPage == index {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    accentColor,
                                    accentColor.opacity(0.7)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: activeDotWidth, height: activeDotHeight)
                        .shadow(color: accentColor.opacity(0.4), radius: 5, x: 0, y: 2)
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: inactiveDotSize, height: inactiveDotSize)
                }
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: currentPage)
    }
}
