//
//  ContentView.swift
//  UserLogin
//
//  Created by Reenad gh on 27/05/1444 AH.
//

import SwiftUI

struct SplashView: View {
    @Binding var isActive : Bool
    
    var body: some View {
        VStack (spacing : 40){
            
          Image("logo_1")
                .foregroundColor(.gray)
                ProgressView()
                .scaleEffect(2.4)

        }
        .onAppear{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActive = false
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(isActive: .constant(true))
    }
}
