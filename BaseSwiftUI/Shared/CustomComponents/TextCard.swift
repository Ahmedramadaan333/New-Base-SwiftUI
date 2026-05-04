//
//  TextCard.swift
//  CTF
//
//  Created by Ahmed Ramadan on 22/12/2025.
//


 import SwiftUI

 struct TextCard: View {
    let title: String
    let text: String
    
    var body: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(AppFont.bold(size: 16))
                    .foregroundColor(.primaryText)
                
                Text(text)
                    .font(AppFont.regular(size: 15))
                    .foregroundColor(.primaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
