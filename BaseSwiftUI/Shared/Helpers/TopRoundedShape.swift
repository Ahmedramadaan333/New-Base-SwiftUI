//
//  TopRoundedShape.swift
//  CTF
//
//  Created by Ahmed Ramadan on 25/11/2025.
//


import SwiftUI

struct TopRoundedShape: Shape {
    var radius: CGFloat = 16
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
