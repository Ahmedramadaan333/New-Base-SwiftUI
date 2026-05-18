//
//  ChangePhoneView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 06/12/2025.
//

import SwiftUI

struct ChangePhoneView: View {
    @StateObject var viewModel: ChangePhoneViewModel
    @EnvironmentObject var moreCoordinator: MoreCoordinator

    init(viewModel: ChangePhoneViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        BaseScreen(title: "change_phone_title".localized) {
            VStack{
                VStack(alignment: .leading, spacing: 16) {
                    PhoneTextView(
                        title: "new_phone_title".localized,
                        placeHolder: "new_phone_placeholder".localized,
                        phone: $viewModel.phone,
                        selectedCountry: $viewModel.selectedCountry,
                        hasError: viewModel.phoneHasError,
                        errorMessage: viewModel.phoneError,
                        items: viewModel.countries,
                        height: 50
                    )
                    
                    VStack {
                        MainAppButton(
                            title: "confirm_title".localized,
                            action: {
                                let countryCode = viewModel.selectedCountry?.countryCode
                                let model = UserRegisterModel(
                                    phone: viewModel.phone,
                                    countryCode: countryCode
                                )
                                viewModel.validateLogin(model: model)
                            }
                        )
                    }
                    .padding(8)
                    Spacer()
                }
                .padding(4)
            }
            .alert(for: viewModel)
            .loader(for: viewModel)
            .onAppear {
                viewModel.getCountries()
            }
            .onReceive(viewModel.$isSendSmsToNewPhone) { response in
                guard let response else {return}
                moreCoordinator.push(.verifyNewPhoneNumber(phone: response.phone ?? "" , countryCode: response.countryCode ?? ""))
            }
        }
    }
}
