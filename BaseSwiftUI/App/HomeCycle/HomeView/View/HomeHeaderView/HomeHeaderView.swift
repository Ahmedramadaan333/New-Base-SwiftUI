//
//  HomeHeaderView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 08/12/2025.
//

import SwiftUI

struct HomeHeaderView: View {
    var openNotification: VoidCompletion
    var body: some View {
        ZStack {
            Image(.backgroundNavStack)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .clipped()
            
            HStack {
                Spacer()
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26,height: 26)
                
                Spacer()
                
                Button {
                    openNotification()
                } label: {
                    Image(.notificationBell)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .padding(8)
                }
                .padding(.trailing, 16)
            }
            .padding(.top, 50)
        }
        .frame(height: 120)
    }
}
