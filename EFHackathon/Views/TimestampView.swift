//
//  TimestampView.swift
//  EFxMetaxHuggingfacexScaleway
//
//  Created by Martin Mohammed on 22.11.24.
//

import SwiftUI

struct TimestampView: View {
    var timeString: String
    var body: some View {
        Text(timeString)
            .font(.caption)
            .foregroundColor(.gray)

    }
}

#Preview {
    TimestampView(timeString: "18:11")
}
