//
//  SplashView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 16/11/2025.
//
import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject private var languageManager = AppLanguageManager.shared

    @State private var showFirstImage = false
    @State private var showSecondImage = false

    var body: some View {
        ZStack {
            Image(.splashBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer()
                if languageManager.isRTL {
                    HStack(spacing: 8) {
                        Image(.ctf)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .opacity(showSecondImage ? 1 : 0)
                            .offset(x: showSecondImage ? 0 : (languageManager.isRTL ? -150 : 150))
                            .animation(.easeOut(duration: 0.6), value: showSecondImage)
                        Image(.splashLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .opacity(showFirstImage ? 1 : 0)
                            .scaleEffect(showFirstImage ? 1 : 0.7)
                            .animation(.easeOut(duration: 0.5), value: showFirstImage)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 32)
                    
                    Spacer()
                }
                else {
                    HStack(spacing: 8) {
                        Image(.splashLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .opacity(showFirstImage ? 1 : 0)
                            .scaleEffect(showFirstImage ? 1 : 0.7)
                            .animation(.easeOut(duration: 0.5), value: showFirstImage)
                        
                        Image(.ctf)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .opacity(showSecondImage ? 1 : 0)
                            .offset(x: showSecondImage ? 0 : (languageManager.isRTL ? -150 : 150))
                            .animation(.easeOut(duration: 0.6), value: showSecondImage)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 32)
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            startSequence()
        }
    }

    private func startSequence() {
        showFirstImage = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            showSecondImage = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            appCoordinator.decideInitialRoot()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
