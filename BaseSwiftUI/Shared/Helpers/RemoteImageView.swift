//
//  RemoteImageView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 08/12/2025.
//

import SwiftUI
import Kingfisher

struct RemoteImageView: View {
    
    let url: String?
    
    var body: some View {
        KFImage.url(URL(string: url ?? "" ))
            .placeholder {
                Image(.logo)
                    .resizable()
                
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .overlay {
                        ProgressView()
                    }
            }
            .resizable()
    }
}
