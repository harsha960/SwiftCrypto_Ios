//
//  SwiftCryptoApp.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 03/08/23.
//

import SwiftUI

@main
struct SwiftCryptoApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
