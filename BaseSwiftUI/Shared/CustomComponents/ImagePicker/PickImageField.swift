//
//  PickImageField.swift
//  CTF
//
//  Created by Ahmed Ramadan on 15/12/2025.
//

import SwiftUI

struct PickImageField: View {

    let title: String
    let placeholder: String

    // output
    @Binding var data: Data?

    // reuse your coordinator
    @StateObject var picker: ImagePickerCoordinator

    // UI config
    var previewSize: CGSize = .init(width: 64, height: 64)

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            Text(title)
                .font(AppFont.semiBold(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)

            Button {
                picker.showPickerOptions()
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "square.and.arrow.up")
                        .font(AppFont.semiBold(size: 16))
                        .opacity(0.6)

                    Text(placeholder)
                        .font(AppFont.regular(size: 14))
                        .opacity(0.55)

                    Spacer()
                }
                .padding(.horizontal, 14)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)

            // preview (hide if nil)
            if let img = picker.selectedImage {
                VStack(alignment: .leading){
                    HStack() {
                        
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFill()
                                .frame(width: previewSize.width, height: previewSize.height)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Button {
                                picker.clear()
                            } label: {
                                ZStack {
                                    Circle().fill(Color.white)
                                        .frame(width: 22, height: 22)
                                    Image(systemName: "trash.fill")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(.red)
                                }
                                .offset(x: -6, y: -6)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .onReceive(picker.$selectedData) { newValue in
            data = newValue
        }
        .imagePickerSheet(picker, allowsEditing: true)
    }
}

