//
//  ImagePicker.swift
//  CTF
//
//  Created by Ahmed Ramadan on 24/11/2025.
//


import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.dismiss) private var dismiss

    let sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?
    var allowsEditing: Bool = true

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.allowsEditing = allowsEditing
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        let parent: ImagePicker
        init(parent: ImagePicker) { self.parent = parent }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            let imageKey: UIImagePickerController.InfoKey = parent.allowsEditing ? .editedImage : .originalImage
            let image = (info[imageKey] as? UIImage) ?? (info[.originalImage] as? UIImage)
            parent.selectedImage = image
            parent.dismiss()
        }
    }
}

