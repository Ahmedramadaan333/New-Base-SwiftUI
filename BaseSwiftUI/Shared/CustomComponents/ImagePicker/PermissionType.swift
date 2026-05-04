//
//  PermissionType.swift
//  CTF
//
//  Created by Ahmed Ramadan on 24/11/2025.
//


import AVFoundation
import Photos

enum PermissionType {
    case camera
    case photoLibrary
}

final class PermissionsManager {
    
    static let shared = PermissionsManager()
    
    private init() { }
    
    // MARK: - CAMERA
    func checkCameraPermission(_ completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized: completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { completion(granted) }
            }
        case .denied, .restricted:
            completion(false)
        default:
            completion(false)
        }
    }
    
    // MARK: - PHOTO LIBRARY
    func checkPhotoLibraryPermission(_ completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch status {
        case .authorized, .limited:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized || newStatus == .limited)
                }
            }
        case .denied, .restricted:
            completion(false)
        default:
            completion(false)
        }
    }
}
