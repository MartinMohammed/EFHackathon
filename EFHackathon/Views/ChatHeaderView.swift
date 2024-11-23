//
//  ChatHeaderView.swift
//  EFxMetaxHuggingfacexScaleway
//
//  Created by Martin Mohammed on 22.11.24.
//

import SwiftUI

struct ChatHeaderView: View {
    @Binding var isSpeakerOn: Bool
    
    var body: some View {
        HStack {
            // Header Left
            HStack(spacing: 10) {
                Image("painter")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                Text("Explore Art")
                    .font(.headline)
            }
            .padding(.leading)
            
            Spacer()
            
            Button(action: {
                withAnimation(.spring()) {
                    isSpeakerOn.toggle()
                }
            }) {
                Image(systemName: isSpeakerOn ? "speaker.minus.fill" : "speaker.plus.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.black)
            }
            .padding(.trailing)
            .accessibilityLabel(isSpeakerOn ? "Turn speaker off" : "Turn speaker on")
        }
    }
}

struct ChatHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChatHeaderView(isSpeakerOn: .constant(true))
                .padding()
                .previewDisplayName("Speaker On")
            
            ChatHeaderView(isSpeakerOn: .constant(false))
                .padding()
                .previewDisplayName("Speaker Off")
            
            ChatHeaderView(isSpeakerOn: .constant(true))
                .padding()
                .preferredColorScheme(.dark)
                .previewDisplayName("Speaker On - Dark Mode")
        }
    }
}
