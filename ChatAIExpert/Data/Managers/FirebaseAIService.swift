//
//  FirebaseAIService.swift
//  ChatAI
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import Foundation
import FirebaseAI

class FirebaseAIService {
    static let shared = FirebaseAIService()
    
    private let ai: FirebaseAI
    
    private init() {
        self.ai = FirebaseAI.firebaseAI(backend: .googleAI())
       }
    
    func createGenerativeModel() -> GenerativeModel {
           return ai.generativeModel(modelName: "gemini-2.0-flash-lite-001")
       }
       
    
    func createChat() -> Chat {
        let model = createGenerativeModel()
        return model.startChat()
    }
} 
