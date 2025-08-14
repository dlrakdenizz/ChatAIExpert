//
//  ChatbotCategory.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 13.07.2025.
//

import Foundation

enum ChatbotCategory: String, CaseIterable, Identifiable {
    case saved = "Saved"
    case popular = "Popular"
    case relationship = "Relationship"
    case health = "Health"
    case language = "Language"
    case education = "Education"

    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .saved: return "bookmark.fill"
        case .popular : return "sparkles"
        case .relationship: return "bubble.left.and.bubble.right"
        case .health: return "cross.case"
        case .language: return "text.bubble"
        case .education: return "book.fill"
        }
    }
    
    var localizedName: String {
          localized(self.rawValue)
      }
}
