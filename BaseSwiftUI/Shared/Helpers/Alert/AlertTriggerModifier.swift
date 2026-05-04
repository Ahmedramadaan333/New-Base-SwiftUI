//
//  AlertTriggerModifier.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//


import SwiftUI
import Combine

struct AlertTriggerModifier<VM>: ViewModifier where VM: BaseViewModel {
    @ObservedObject var viewModel: VM
    @EnvironmentObject var alertCenter: AlertCenter
    
    func body(content: Content) -> some View {
        content
            .onReceive(viewModel.errorSubject) { error in
                alertCenter.show(
                    style: .error,
                    title: "Error".localized,
                    message: error.localizedDescription
                )
            }
            .onReceive(viewModel.successSubject) { message in
                alertCenter.show(
                    style: .success,
                    message: message
                )
            }
            .onReceive(viewModel.warningSubject) { message in
                alertCenter.show(
                    style: .warning,
                    title: "Warning".localized,
                    message: message
                )
            }
    }
}

extension View {
    func alert<VM: BaseViewModel>(for viewModel: VM) -> some View {
        self.modifier(AlertTriggerModifier(viewModel: viewModel))
    }
}
