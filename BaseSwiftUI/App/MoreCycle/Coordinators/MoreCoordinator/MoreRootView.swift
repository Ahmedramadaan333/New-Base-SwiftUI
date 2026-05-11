//
//  MoreRootView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 26/11/2025.
//


import SwiftUI

struct MoreRootView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @EnvironmentObject var moreCoordinator: MoreCoordinator
    @EnvironmentObject var termsCoordinator: TermsCoordinator
    
    var body: some View {
        NavigationStack(path: $moreCoordinator.path) {
            MoreScreen()
            
        }
        .environmentObject(appCoordinator)
        .environmentObject(moreCoordinator)
        .environmentObject(termsCoordinator)
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(for: MoreCoordinatorRoute.self) { route in
            moreCoordinator.destination(for: route)
        }
        .sheet(item: $moreCoordinator.modalRoute) { modal in
            switch modal {
            case .changeLanguage:
                LanguageSheetView {
                    moreCoordinator.dismissModal()
                }
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled(false)
                .presentationCornerRadius(40)
            }
        }
    }
}
