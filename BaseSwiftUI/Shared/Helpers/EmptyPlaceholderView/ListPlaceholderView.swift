//
//  ListPlaceholderView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 11/12/2025.
//


import SwiftUI

struct ListPlaceholderView: View {
    
    struct Action: Identifiable {
        let id = UUID()
        let title: String
        let action: () -> Void
    }
    
    let imageName: String?
    let title: String?
    let message: String?
    let actions: [Action]
    
    init(
        imageName: String? = nil,
        title: String? = nil,
        message: String? = nil,
        actions: [Action] = []
    ) {
        self.imageName = imageName
        self.title = title
        self.message = message
        self.actions = actions
    }
    
    var body: some View {
        VStack(spacing: 12) {
            
            if let imageName, !imageName.isEmpty {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .cornerRadius(24)
                    .clipped()
            }
            
            if let title, !title.isEmpty {
                Text(title)
                    .font(AppFont.bold(size: 18))
                    .foregroundColor(Color(.secondaryLabel))
                    .multilineTextAlignment(.center)
            }
            
            if let message, !message.isEmpty {
                Text(message)
                    .font(AppFont.regular(size: 15))
                    .foregroundColor(Color(.secondaryLabel))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            
            if !actions.isEmpty {
                HStack(spacing: 12) {
                    ForEach(actions) { item in
                        Button(action: item.action) {
                            Text(item.title)
                                .font(AppFont.medium(size: 15))
                                .foregroundColor(Color(.primaryMain))
                                .frame(height: 50)
                                .frame(minWidth: 120)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color(.secondarySystemFill), lineWidth: 1)
                                )
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}
import SwiftUI

extension View {
    @ViewBuilder
    func emptyPlaceholder(
        isEmpty: Bool,
        style: ListPlaceholderStyle,
        onPrimaryAction: (() -> Void)? = nil
    ) -> some View {
        if isEmpty {
            ListPlaceholderView(
                style: style,
                primaryAction: onPrimaryAction
            )
        } else {
            self
        }
    }
}
