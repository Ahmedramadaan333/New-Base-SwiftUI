//
//  ContentView.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State var sampleText: String = ""
    var body: some View {

        RootCoordinatorView()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppCoordinator())
    }
}
