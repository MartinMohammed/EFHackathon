import SwiftUI

struct MessageItem: View {
    let message: ChatMessageModel
    
    var body: some View {
        VStack(alignment: message.isUser ? .trailing : .leading, spacing: 5) {
            switch message.content {
            case .text(let text):
                Text(text)
                    .padding()
                    .background(message.isUser ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundColor(message.isUser ? Color.white : Color.black)
                    .cornerRadius(10)
            case .image(let uiImage):
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 150)
                    .cornerRadius(10)
            }
            
            Text(message.timeString)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
}

struct MessageItemWithTextContentView_Previews: PreviewProvider {
    static var previews: some View {
        MessageItem(message: ChatMessageModel(isUser: true, content: .text("Hi")))
    }
}

struct MessageItemWithImageContentView_Previews: PreviewProvider {
    static var previews: some View {
        MessageItem(message: ChatMessageModel(isUser: false, content: .image(UIImage(named: "background-LC") ?? UIImage())))
        
    }
}


