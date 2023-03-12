//
//  StartTempleteView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 03/08/1444 AH.
//

import Foundation
import SwiftUI
struct StartTempleteView <Content : View> : View{
    
    let content: Content
    
    var body: some View {
        
        ZStack {
            NCGRBackground()

            VStack (spacing: 35){
                Image("logo_1")
                    .padding(.top , 50)
                content
                Spacer()
                
            }
        }
    }
}

struct StartTempleteView_Previews: PreviewProvider {
    static var previews: some View {
        StartTempleteView(content: Text(""))
    }
}


struct NCGRBackground: View {

    var body: some View {
        
        VStack {
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .offset(x : 50 , y : 50)
                .frame(maxWidth : .infinity , alignment: .trailing)
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
}
