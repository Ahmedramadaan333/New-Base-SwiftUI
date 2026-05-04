//
//  ImagePickerCoordinator.swift
//  CTF
//
//  Created by Ahmed Ramadan on 24/11/2025.
//


import SwiftUI
import UIKit

final class ImagePickerCoordinator: ObservableObject {
    
    @Published var showOptions = false
    @Published var showCameraPicker = false
    @Published var showGalleryPicker = false
    @Published var selectedImage: UIImage? {
        didSet { syncDataFromImage() }
    }

    @Published var selectedData: Data? = nil
    var compressionQuality: CGFloat = 0.6
    var onPicked: ((UIImage?, Data?) -> Void)? = nil

    func showPickerOptions() {
        showOptions = true
    }

    func pickSource(_ source: UIImagePickerController.SourceType) {
        switch source {
        case .camera:
            PermissionsManager.shared.checkCameraPermission { [weak self] granted in
                DispatchQueue.main.async {
                    guard let self else { return }
                    granted ? (self.showCameraPicker = true) : self.showSettingsAlert()
                }
            }

        case .photoLibrary:
            PermissionsManager.shared.checkPhotoLibraryPermission { [weak self] granted in
                DispatchQueue.main.async {
                    guard let self else { return }
                    granted ? (self.showGalleryPicker = true) : self.showSettingsAlert()
                }
            }

        default:
            break
        }
    }

    func clear() {
        selectedImage = nil
        selectedData = nil
        onPicked?(nil, nil)
    }

    private func syncDataFromImage() {
        let data = selectedImage?.jpegData(compressionQuality: compressionQuality)
        selectedData = data
        onPicked?(selectedImage, data)
    }

    private func showSettingsAlert() {
        guard
            let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
            let window = windowScene.windows.first(where: { $0.isKeyWindow })
        else { return }

        let alert = UIAlertController(
            title: "Permission Required",
            message: "Please enable access from Settings.",
            preferredStyle: .alert
        )

        alert.addAction(.init(title: "Cancel", style: .cancel))
        alert.addAction(.init(title: "Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))

        window.rootViewController?.present(alert, animated: true)
    }
}


