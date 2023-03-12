//
//  CafeteriaAppApp.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 27/07/1444 AH.
//

import SwiftUI

@main
struct CafeteriaAppApp: App {
    
    @StateObject var  authViewModel  : AuthViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environment(\.locale, Locale(identifier: "ar"))

        }
    }
}
