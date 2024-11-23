import SwiftUI

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        // Create the blur effect
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(blurView)
        
        // Add constraints to fill the view
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        // No update needed
    }
}
