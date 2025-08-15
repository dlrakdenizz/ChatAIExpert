//
//  SpeechManager.swift
//  ChatAIExpert
//
//  Created by Dilara Akdeniz on 16.08.2025.
//

import Foundation
import AVFoundation
import NaturalLanguage

class SpeechManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking = false
    
    // Ses tercihi için enum
    enum VoiceGender {
        case male
        case female
        case unspecified
    }
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func speak(_ text: String, languageCode: String, voiceGender: VoiceGender = .female) {
        let utterance = AVSpeechUtterance(string: text)
        
        // Dil ve cinsiyete göre ses seçimi
        let selectedVoice = selectVoice(for: languageCode, gender: voiceGender)
        utterance.voice = selectedVoice
        
        // Konuşma hızı ve ton ayarları
        utterance.rate = 0.5 // Biraz yavaş
        utterance.pitchMultiplier = voiceGender == .female ? 1.2 : 0.8
        
        isSpeaking = true
        synthesizer.speak(utterance)
    }
    
    private func selectVoice(for languageCode: String, gender: VoiceGender) -> AVSpeechSynthesisVoice? {
        let voices = AVSpeechSynthesisVoice.speechVoices()
        
        // İlk olarak belirtilen dil için sesleri filtrele
        let voicesForLanguage = voices.filter { voice in
            voice.language.hasPrefix(languageCode.prefix(2).lowercased())
        }
        
        // Cinsiyete göre ses seçimi
        var preferredVoice: AVSpeechSynthesisVoice?
        
        switch gender {
        case .female:
            preferredVoice = voicesForLanguage.first { voice in
                voice.gender == .female
            }
        case .male:
            preferredVoice = voicesForLanguage.first { voice in
                voice.gender == .male
            }
        case .unspecified:
            preferredVoice = voicesForLanguage.first
        }
        
        // Eğer tercih edilen cinsiyet bulunamazsa, o dildeki herhangi bir sesi kullan
        if preferredVoice == nil {
            preferredVoice = voicesForLanguage.first
        }
        
        // Hiçbir ses bulunamazsa, varsayılan dil sesini kullan
        return preferredVoice ?? AVSpeechSynthesisVoice(language: languageCode)
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
    
    // Mevcut sesleri listeleme (debug için)
    func getAvailableVoices(for languageCode: String) {
        let voices = AVSpeechSynthesisVoice.speechVoices()
        print("📢 Mevcut sesler (\(languageCode)):")
        
        for voice in voices {
            if voice.language.hasPrefix(languageCode.prefix(2).lowercased()) {
                let genderText = voice.gender == .female ? "👩 Kadın" :
                                voice.gender == .male ? "👨 Erkek" : "❓ Belirsiz"
                print("- \(voice.name): \(genderText) (\(voice.language))")
            }
        }
    }
    
    // MARK: - AVSpeechSynthesizerDelegate
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
        }
    }
}

