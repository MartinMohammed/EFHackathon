//
//  MessageListView.swift
//  EFxMetaxHuggingfacexScaleway
//
//  Created by Martin Mohammed on 22.11.24.
//

import SwiftUI

// Subview: Message List View
struct MessageListView: View {
    let messages: [ChatMessageModel]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(messages) { message in
                    HStack {
                        if message.isUser {
                            Spacer()
                            MessageItem(message: message)
                        } else {
                            MessageItem(message: message)
                            Spacer()
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView(
            messages: [
                // Example with image
                ChatMessageModel(isUser: true, content: .image(UIImage(named: "background-LC") ?? UIImage()) ),
                ChatMessageModel(isUser: false, content: .text("This is Mona Lisa, isn't it?")),
                ChatMessageModel(isUser: true, content: .text("Yes, how do you know?")),
            ]
        )
    }
}
