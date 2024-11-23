import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            // Navigate to your main content view after the splash screen
            ContentView()
        } else {
            // Your splash screen content
            Image("background-LC")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea() // Extend the image to cover the entire screen, including safe areas
                .onAppear {
                    // Duration for which the splash screen is displayed
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
}
