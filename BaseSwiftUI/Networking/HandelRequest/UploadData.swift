//
//  UploadData.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 21/12/2023.
//

import Foundation

struct UploadData {
    var key: String
    var data: Data
    var mimeType: mimeType
    var fileName: String = UUID().uuidString
    var filenameWithExtension: String {
        "\(fileName)\(mimeType.extension)"
    }
}

enum mimeType: String {
    case jpeg = "image/jpeg"
    case pdf = "application/pdf"
    case m4a = "audio/m4a"
    case mp4 = "video/mp4"
    
    fileprivate var `extension`: String {
        switch self {
        case .jpeg:
            return ".jpeg"
        case .pdf:
            return ".pdf"
        case .m4a:
            return ".m4a"
        case .mp4:
            return ".mp4"
        }
    }
    
}
