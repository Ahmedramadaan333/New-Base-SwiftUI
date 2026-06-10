//
//  AppTextFieldIcon.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 10/06/2026.
//

import SwiftUI

struct AppTextFieldIcon: View {
    var iconField: UIImage?
    var body: some View {
        if let iconField = iconField {
            Image(uiImage: iconField)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color(.secondaryLabel))
                .frame(width: 20, height: 20)
        }
    }
}
