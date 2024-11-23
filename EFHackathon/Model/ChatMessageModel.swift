//
//  ChatMessageModel.swift
//  EFxMetaxHuggingfacexScaleway
//
//  Created by Martin Mohammed on 22.11.24.
//

import Foundation
import SwiftUI

enum MessageContent {
    case text(String)
    case image(UIImage)
}

struct ChatMessageModel: Identifiable {
    let id = UUID()
    let isUser: Bool
    let timestamp: Date = Date()
    // exhaustive, either contains text or image. 
    let content: MessageContent
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: timestamp)
    }
}
