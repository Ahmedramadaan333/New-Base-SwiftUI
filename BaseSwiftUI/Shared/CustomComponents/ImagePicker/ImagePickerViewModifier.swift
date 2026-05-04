//
//  ImagePickerViewModifier.swift
//  CTF
//
//  Created by Ahmed Ramadan on 24/11/2025.
//


import SwiftUI

struct ImagePickerViewModifier: ViewModifier {
    @ObservedObject var coordinator: ImagePickerCoordinator

    var allowsEditing: Bool = true

    func body(content: Content) -> some View {
        content
            .confirmationDialog(
                "choose_image_source_title".localized,
                isPresented: $coordinator.showOptions,
                titleVisibility: .visible
            ) {
                Button("camera_title".localized) {
                    coordinator.pickSource(.camera)
                }
                Button("gallery_title".localized) {
                    coordinator.pickSource(.photoLibrary)
                }
                Button("cancel_title".localized, role: .cancel) { }
            }
            .sheet(isPresented: $coordinator.showCameraPicker) {
                ImagePicker(
                    sourceType: .camera,
                    selectedImage: $coordinator.selectedImage,
                    allowsEditing: allowsEditing
                )
            }
            .sheet(isPresented: $coordinator.showGalleryPicker) {
                ImagePicker(
                    sourceType: .photoLibrary,
                    selectedImage: $coordinator.selectedImage,
                    allowsEditing: allowsEditing
                )
            }
    }
}

extension View {
    func imagePickerSheet(_ coordinator: ImagePickerCoordinator) -> some View {
        modifier(ImagePickerViewModifier(coordinator: coordinator, allowsEditing: true))
    }

    func imagePickerSheet(_ coordinator: ImagePickerCoordinator, allowsEditing: Bool) -> some View {
        modifier(ImagePickerViewModifier(coordinator: coordinator, allowsEditing: allowsEditing))
    }
}
