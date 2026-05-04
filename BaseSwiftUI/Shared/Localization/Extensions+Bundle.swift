//
//  Extensions+Bundle.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import SwiftUI

extension Bundle {
    static func setLanguage(_ language: String) {
        objc_setAssociatedObject(Bundle.main, &AssociatedKeys.bundleKey, Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj")!), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        object_setClass(Bundle.main, CustomBundle.self)
    }

    private struct AssociatedKeys {
        static var bundleKey: UInt8 = 0
    }

    private class CustomBundle: Bundle, @unchecked Sendable {
        override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
            guard let bundle = objc_getAssociatedObject(self, &AssociatedKeys.bundleKey) as? Bundle else {
                return super.localizedString(forKey: key, value: value, table: tableName)
            }
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}
