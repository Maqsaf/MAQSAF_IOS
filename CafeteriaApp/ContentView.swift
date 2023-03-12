//
//  ContentView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 27/07/1444 AH.
import SwiftUI

struct ContentView: View {
    @State var isSplashViewActive : Bool = true

    @EnvironmentObject var  authViewModel  : AuthViewModel

    var body: some View {
        
        if (isSplashViewActive && authViewModel.user.id == "" ){
            SplashView(isActive: $isSplashViewActive)
            
        }else if ( authViewModel.user.id != ""){
            HomeView()
                .environment(\.layoutDirection, .rightToLeft)
            
        } else {
            AuthView()
                .environment(\.layoutDirection, .rightToLeft)

                .onAppear{
                    authViewModel.fetchUser()
                }
        }
         
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
