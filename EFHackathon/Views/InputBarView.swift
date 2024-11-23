//
//  InputBarView.swift
//  EFxMetaxHuggingfacexScaleway
//
//  Created by Martin Mohammed on 22.11.24.
//

import SwiftUI

// Subview: Input Bar View
struct InputBarView: View {
    @Binding var inputText: String
    @Binding var inputDisabled: Bool
    var onSend: () -> Void
    var onPhotoPicker: () -> Void
    
    var body: some View {
        HStack {
            // Photo Picker Button
            Button(action: onPhotoPicker) {
                Image(systemName: "video.fill")
                    .font(.system(size: 24))
                    .opacity(inputDisabled ? 0.5 : 1.0)
            }
            
            // Text Field
            TextField("Type a message...", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disabled(inputDisabled)
            
            // Send Button
            Button(action: onSend) {
                Text("Send")
                    .bold()
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || inputDisabled)
            .opacity(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || inputDisabled ? 0.5 : 1.0)
        }.padding(.vertical)

    }
}

struct InputBarView_Previews: PreviewProvider {
    static var previews: some View {
            InputBarView(
                inputText: .constant("Sample message"),
                inputDisabled: .constant(false),
                onSend: { /* Action for send button */ },
                onPhotoPicker: { /* Action for photo picker button */ }
            )
            .previewLayout(.sizeThatFits)
    }
}
