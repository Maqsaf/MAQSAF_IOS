//
//  ProgressView.swift
//  NCGRCards
//
//  Created by Reenad gh on 14/07/1444 AH.
//

import SwiftUI

struct NCGRProgressView: View {
    @State var isAnimeting : Bool = false
    var body: some View {
        ZStack {
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.appColor(.darkBlue)))
                    .scaleEffect( 1.6)
                    .padding()
                Text("إنتظر قليلا ..")
                    .foregroundColor(Color.appColor(.darkBlue))
                    .font(.DinNextArabicMedium(size: 17))
                
            }
            .frame(width: 120)
            .frame(height: 120)
            .background(Color.white)
            .cornerRadius(  9 )
            .scaleEffect(  isAnimeting ? 1 : 0.2)
            .shadow(color: .black.opacity(0.3), radius: 25, x: 1, y: 2)
            
            
            
        }
        .frame(maxWidth : .infinity , maxHeight: .infinity)
        .background(Color.black.opacity(isAnimeting ? 0.2 : 0))
        
        .onAppear{
            withAnimation(.spring()){
                isAnimeting = true
            }
        }
        .onDisappear{
            withAnimation(.spring()){
                isAnimeting = false
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        NCGRProgressView()
    }
}


