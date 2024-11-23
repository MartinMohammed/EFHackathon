//
//  GetSpeechSynthesis.swift
//  EFxMetaxHuggingfacexScaleway
//
//  Created by Martin Mohammed on 22.11.24.
//

import Foundation
import AVFoundation

/// A helper class for managing speech synthesis.
class SpeechSynthesizerHelper: NSObject, AVSpeechSynthesizerDelegate {
    
    // MARK: - Properties
    
    private let synthesizer: AVSpeechSynthesizer
    private var completionHandler: (() -> Void)?
    
    // MARK: - Initialization
    
    override init() {
        self.synthesizer = AVSpeechSynthesizer()
        super.init()
        self.synthesizer.delegate = self
    }
    
    // MARK: - Public Methods
    
    /// Synthesizes speech from the given text.
    ///
    /// - Parameters:
    ///   - text: The text to be spoken.
    ///   - language: The language code for the voice. Default is "en-GB".
    ///   - speed: The rate at which the utterance is spoken. Range is 0.0 to 1.0. Default is 0.57.
    ///   - pitch: The pitch multiplier for the voice. Range is 0.5 to 2.0. Default is 0.8.
    ///   - volume: The volume of the speech. Range is 0.0 to 1.0. Default is 0.8.
    ///   - completion: An optional closure to be called when the speech finishes.
    func synthesizeSpeech(
        text: String,
        language: String = "en-GB",
        speed: Float = 0.57,
        pitch: Float = 0.8,
        volume: Float = 0.8,
        completion: (() -> Void)? = nil
    ) {
        // Create an utterance.
        let utterance = AVSpeechUtterance(string: text)
        
        // Configure the utterance.
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * speed
        utterance.pitchMultiplier = pitch
        utterance.postUtteranceDelay = 0.2
        utterance.volume = volume
        
        // Set the voice.
        if let voice = AVSpeechSynthesisVoice(language: language) {
            utterance.voice = voice
        } else {
            print("Warning: Voice for language '\(language)' not found. Using default voice.")
        }
        
        // Assign the completion handler if on instantiation was none defined.
        if let completion = completion {
            self.completionHandler = completion
        }
        
        // Speak the utterance.
        synthesizer.speak(utterance)
    }
    
    // MARK: - AVSpeechSynthesizerDelegate
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        completionHandler?()
        completionHandler = nil // reset
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        completionHandler = nil // reset
    }
}
