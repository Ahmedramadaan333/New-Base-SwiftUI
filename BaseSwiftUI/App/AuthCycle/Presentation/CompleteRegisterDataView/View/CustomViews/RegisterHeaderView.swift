//
//  RegisterHeaderView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 25/11/2025.
//


import SwiftUI

struct RegisterHeaderView: View {
    @EnvironmentObject var authCoordinator: AuthCoordinator
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image(.back)
                .resizable()
                .scaledToFill()
            
            Button {
                authCoordinator.popToRoot()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.primary)
                    .padding()
            }
        }
    }
}
