//
//  String+InputLocalized.swift
//  JaaferElwan
//
//  Created by Eslam on 17/03/2025.
//

import Foundation

extension String {
    var inputLocalized: String{
        return NSLocalizedString(self, tableName: "InputViewLocalizable", bundle: Bundle.main, value: "", comment: "")
    }
}
