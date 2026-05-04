//
//  ProfileImagePickerView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 24/11/2025.
//


import SwiftUI

struct ProfileImagePickerView: View {
    @Binding var image: UIImage?
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                Circle()
                    .strokeBorder(Color.primaryMain, lineWidth: 2)
                    .frame(width: 110, height: 110)
                    .background(
                        Circle()
                            .fill(Color.white)
                    )
                
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Image(.user)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primaryMain.opacity(0.7))
                        .frame(width: 70, height: 70)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 32, height: 32)
                            
                            Circle()
                                .stroke(Color.primaryMain, lineWidth: 1)
                                .frame(width: 32, height: 32)
                            
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                                .foregroundColor(.primaryMain)
                        }
                        .offset(x: 0, y: 0)
                    }
                }
                .frame(width: 110, height: 110)
            }
        }
        .buttonStyle(.plain)
    }
}
