//
//  PhotoPicker.swift
//  EFxMetaxHuggingfacexScaleway
//
//  Created by Martin Mohammed on 22.11.24.
//

import SwiftUI
import PhotosUI

// Subview: Photo Picker
struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var onImageSelected: (() -> Void)? // Callback for image upload

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }

            provider.loadObject(ofClass: UIImage.self) { (image, error) in
                if let uiImage = image as? UIImage {
                    DispatchQueue.main.async {
                        
                        self.parent.selectedImage = uiImage
                        print("Image selected from gallery")
                        self.parent.onImageSelected?() // Trigger the callback
                    }
                }
            }
        }
    }
}

