//
//  ContentView.swift
//  EFxMetaxHuggingfacexScaleway
//
//  Created by Martin Mohammed on 22.11.24.
//

import SwiftUI

struct ContentView: View {
    // Initialize the speech synthesizer helper
    private let speechHelper = SpeechSynthesizerHelper()
    
    // Contains all the messages that make up the 'chat'
    @State private var messages: [ChatMessageModel] = []
    // The text that is currently inside the input field
    @State private var inputText: String = ""
    // Whether TextField is disabled or not. Important for response handling of user message.
    @State private var inputDisabled = false
    // The image that is currently selected
    @State private var selectedImage: UIImage?
    
    @State private var isSpeakerOn: Bool = false
    
    // Whether to show the photo picker sheet
    @State private var isPhotoPickerPresented: Bool = false
    
    var body: some View {
        VStack {
            ChatHeaderView(isSpeakerOn: $isSpeakerOn)
            
            Divider()
            
            // Chat Content
            ZStack {
                VStack {
                    // Message List View
                    MessageListView(messages: messages)
                    
                    Divider()
                    
                    // Input Bar View
                    InputBarView(
                        inputText: $inputText,
                        inputDisabled: $inputDisabled, // Pass as binding
                        onSend: handleTextFieldSubmit,
                        onPhotoPicker: { isPhotoPickerPresented = !inputDisabled && true }
                    )
                }
                .disabled(inputDisabled) // Disable interaction when loading
                
                // Loading Spinner Overlay
                if inputDisabled {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ProgressView("Waiting for response...")
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                                .background(BlurView(style: .systemMaterial))
                                .cornerRadius(10)
                            Spacer()
                        }
                        Spacer()
                    }
                    .transition(.opacity)
                }
            }
            .sheet(isPresented: $isPhotoPickerPresented) {
                PhotoPicker(selectedImage: $selectedImage,
                            onImageSelected: handleImageUpload // Handle image uploads
                )
            }
        }
        .padding()
        .onAppear {
            // Optional: Load initial messages if any
            // For example, you can add a welcome message
            let welcomeMessage = ChatMessageModel(isUser: false, content: .text("Welcome to Explore Art! Please upload a picture of your favorite painting or directly ask about it."))
            messages.append(welcomeMessage)
        }
    }
    
    /// Sends a message by appending it to the messages array and triggering a response.
    private func sendMessage(_ message: ChatMessageModel) {
        messages.append(message)
        print("New message sent: \(message.content)")
        
        switch message.content {
        case .text(let text):
            if isSpeakerOn {
                print("Synthesizing speech for: \(text)")
                speechHelper.synthesizeSpeech(
                    text: text,
                    language: "en-US", // Change as needed
                    speed: 0.5,        // Adjust as desired
                    pitch: 1.0,        // Adjust as desired
                    volume: 0.9        // Adjust as desired
                ) {
                    print("Speech synthesis completed.")
                    // You can perform additional actions here if needed
                }
            }
        case .image(_):
            break
            // No action needed for images in speech synthesis
        }
        
        // Respond to the message after a delay
        respondToMessage(message)
    }
    
    /// Handles the submission of text from the input field.
    private func handleTextFieldSubmit() {
        print("New text data was submitted!")
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        inputDisabled = true
        let newMessage = ChatMessageModel(isUser: true, content: .text(inputText))
        inputText = "" // Reset the input
        sendMessage(newMessage)
    }
    
    /// Appends a response message after a 3-second delay.
    private func respondToMessage(_ message: ChatMessageModel) {
        guard message.isUser else { return } // We don't want it to respond to itself.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let response = ChatMessageModel(isUser: false, content: .text("Thank you for your message. I'll get back to you soon."))
            sendMessage(response)
            print("Response message appended.")
            inputDisabled = false
        }
    }
    
    /// Handles the image upload by appending the selected image message.
    private func handleImageUpload() {
        inputDisabled = true
        print("New image was uploaded!")
        if let image = selectedImage {
            let imageMessage = ChatMessageModel(isUser: true, content: .image(image))
            sendMessage(imageMessage)
        } else {
            print("No image was selected.")
            inputDisabled = false // Re-enable input if no image was selected
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
