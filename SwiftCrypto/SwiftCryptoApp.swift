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
<<<<<<< HEAD
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.secondaryText)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        
    }
=======
>>>>>>> dffd75de0a984333e233edd3a4ff99ffb8e1b4af
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
