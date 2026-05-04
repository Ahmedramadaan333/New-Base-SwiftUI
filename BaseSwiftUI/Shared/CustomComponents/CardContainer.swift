//
//  CardContainer.swift
//  CTF
//
//  Created by Ahmed Ramadan on 22/12/2025.
//


import SwiftUI

struct CardContainer<Content: View>: View {
    @ViewBuilder var content: Content
    
    var body: some View {
        content
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
            )
    }
}
