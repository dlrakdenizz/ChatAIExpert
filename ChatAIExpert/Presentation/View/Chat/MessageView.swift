//
//  MessageView.swift
//  ChatAINew
//
//  Created by Dilara Akdeniz on 20.07.2025.
//

import SwiftUI
import AVFoundation
import NaturalLanguage

struct MessageView: View {
    
    var isFromCurrentUser: Bool
    var messageText: String
    let chatbot: Chatbots
    var isTyping: Bool = false
    var imageData: [Data]?
    @State private var dotOffset: CGFloat = 0
    @State private var showingCopyAlert = false
    @StateObject private var speechManager = SpeechManager()
    
    var isSpeaking: Bool {
        speechManager.isSpeaking
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if isFromCurrentUser {
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        if let imageDataArray = imageData {
                            ForEach(imageDataArray, id: \.self) { data in
                                if let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 240)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        
                        if !messageText.isEmpty {
                            Text(messageText)
                                .padding(12)
                                .background(Color.black)
                                .font(.system(size: 15))
                                .clipShape(ChatBubble(isFromCurrentUser: true))
                                .foregroundStyle(Color.white)
                                .onLongPressGesture {
                                    copyMessageToClipboard()
                                }
                                .scaleEffect(showingCopyAlert ? 0.95 : 1.0)
                                .animation(.easeInOut(duration: 0.1), value: showingCopyAlert)
                        }
                    }
                    .padding(.leading, 100)
                    .padding(.horizontal)
                } else {
                    HStack {
                        Image(chatbot.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        
                        if isTyping {
                            HStack(spacing: 4) {
                                ForEach(0..<3) { index in
                                    Circle()
                                        .fill(Color.gray)
                                        .frame(width: 8, height: 8)
                                        .offset(y: dotOffset)
                                        .animation(
                                            Animation.easeInOut(duration: 0.5)
                                                .repeatForever()
                                                .delay(0.2 * Double(index)),
                                            value: dotOffset
                                        )
                                }
                            }
                            .padding(12)
                            .background(Color(.systemGray6))
                            .clipShape(ChatBubble(isFromCurrentUser: false))
                            .onAppear {
                                dotOffset = -5
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 0) {
                                // Ana mesaj
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(messageText)
                                        .padding(.top, 12)
                                        .padding(.horizontal, 12)
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color.black)
                                        .onLongPressGesture {
                                            copyMessageToClipboard()
                                        }
                                        .scaleEffect(showingCopyAlert ? 0.95 : 1.0)
                                        .animation(.easeInOut(duration: 0.1), value: showingCopyAlert)
                                    
                                    // Dinle butonu - bubble içinde
                                    Button(action: {
                                        toggleSpeech()
                                    }) {
                                        HStack(spacing: 6) {
                                            Image(systemName: isSpeaking ? "pause.circle.fill" : "play.circle.fill")
                                                .foregroundColor(.blue)
                                                .font(.system(size: 16))
                                            
                                            Text(isSpeaking ? localized("Stop") : localized("Listen"))
                                                .font(.footnote)
                                                .foregroundColor(.blue)
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(Color.blue.opacity(0.1))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                                )
                                        )
                                        .scaleEffect(isSpeaking ? 0.95 : 1.0)
                                        .animation(.easeInOut(duration: 0.1), value: isSpeaking)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.bottom, 12)
                                    .padding(.top, 8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .background(Color(.systemGray6))
                                .clipShape(ChatBubble(isFromCurrentUser: false))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.trailing, 80)
                    
                    Spacer()
                }
            }
        }
        .overlay(
            Group {
                if showingCopyAlert {
                    VStack {
                        Spacer()
                        ToastView(message: "Mesaj kopyalandı")
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        showingCopyAlert = false
                                    }
                                }
                            }
                    }
                    .padding(.bottom, 120)
                }
            }
        )
    }
    
    // Ses çalma/durdurma fonksiyonu
    private func toggleSpeech() {
        if isSpeaking {
            speechManager.stopSpeaking()
        } else {
            speakMessage(messageText)
        }
    }
    
    private func copyMessageToClipboard() {
        guard !messageText.isEmpty else { return }
        
        UIPasteboard.general.string = messageText
        HapticFeedbacks.success()
        
        withAnimation(.easeInOut(duration: 0.3)) {
            showingCopyAlert = true
        }
    }
    
    // Mesajı okuma fonksiyonu
    private func speakMessage(_ message: String) {
        let languageCode = detectLanguage(for: message)
        
        let voiceGender: SpeechManager.VoiceGender = {
            switch chatbot {
            //Relationship
            case .drLove: return .female
            case .astroAgent : return .female
            case .giftie : return .male
            case .flirty : return .male
            case .loveCode : return .female
            case .nameMystic : return .male
            case .dateGenie : return .male
            case .loveMelody : return .female
            
            //Health
            case .slimmy : return .female
            case .gymbuddy : return .male
            case .nutripal : return .female
            case .musclemax : return .male
            case .burnie : return .male
            case .snoozer : return .male
            case .bitebuddy : return .female
            case .calomate : return .male
            
            //Language
            case .theBritisher : return .male
            case .salsaMaster : return .female
            case .leFrancaisCharmant : return .male
            case .deutscheKraft : return .male
            case .mandarinMagician : return .male
            case .senseiXpert : return .male
            case .vivaItaliano : return .female
            case .turkishDelight : return .female
            
            //Education
            case .mathMaster : return .male
            case .scienceSage : return .female
            case .historyHero : return .male
            case .geoGuru : return .female
            case .litLover : return .female
                
            default: return .female
            }
        }()
        
        speechManager.speak(message, languageCode: languageCode, voiceGender: voiceGender)
        
        // Debug: Mevcut sesleri console'da göster
         speechManager.getAvailableVoices(for: languageCode)
    }
    
    // Dil tespit fonksiyonu
    private func detectLanguage(for message: String) -> String {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(message)
        if let language = recognizer.dominantLanguage {
            switch language {
            case .english:
                return "en-US"
            case .turkish:
                return "tr-TR"
            case .french:
                return "fr-FR"
            case .german:
                return "de-DE"
            case .italian:
                return "it-IT"
            case .korean:
                return "ko-KR"
            case .spanish:
                return "es-ES"
            default:
                return "en-US" // Varsayılan dil olarak İngilizce
            }
        }
        return "en-US"  // Varsayılan dil olarak İngilizce
    }
}


