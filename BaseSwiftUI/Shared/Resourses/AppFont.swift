//
//  AppFont.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 30/07/2025.
//


import SwiftUI

enum AppFont {
    private static let family = "SomarRounded"

    static func black(size: CGFloat) -> Font {
        .custom("\(family)-Black", size: size)
    }

    static func bold(size: CGFloat) -> Font {
        .custom("\(family)-Bold", size: size)
    }

    static func semiBold(size: CGFloat) -> Font {
        .custom("\(family)-SemiBold", size: size)
    }

    static func medium(size: CGFloat) -> Font {
        .custom("\(family)-Medium", size: size)
    }

    static func regular(size: CGFloat) -> Font {
        .custom("\(family)-Regular", size: size)
    }

    static func light(size: CGFloat) -> Font {
        .custom("\(family)-Light", size: size)
    }
}
