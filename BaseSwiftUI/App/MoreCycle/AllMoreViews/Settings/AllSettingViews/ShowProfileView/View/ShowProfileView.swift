//
//  ShowProfileView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 07/12/2025.
//

import SwiftUI
import Kingfisher

struct ShowProfileView: View {
    @StateObject private var viewModel = ShowProfileViewModel()
    var body: some View {
        BaseScreen(title: "show_profile_title".localized) {
            VStack (spacing: 16){
                KFImage(URL(string: UserDefaults.user?.image ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                    )
                    .shadow(radius: 4)
                ShowTextLabelView(
                    title: "username_title".localized,
                    text: viewModel.user?.name ?? "",
                    leadingImage: Image(.name),
                    
                )
                if let email =  viewModel.user?.email{
                    
                    ShowTextLabelView(
                        title: "email_title".localized,
                        text: email,
                        leadingImage: Image(.mail)
                    )
                }
                Spacer()
            }
            .onAppear {
                viewModel.showProfile()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .loader(for: viewModel)
        .alert(for: viewModel)
    }
}
