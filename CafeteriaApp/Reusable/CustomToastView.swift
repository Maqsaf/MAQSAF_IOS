//
//  CustomToastView.swift
//  EmployeeID
//
//  Created by Reenad gh on 16/07/1444 AH.
//

import SwiftUI

struct CustomToastView: View {
    
    @State var isAnimated : Bool = false
    @Binding var isApear : Bool
    var apearTime : CGFloat?
    
    var message : String
    
    var body: some View {
        
        VStack {
            VStack{
                HStack (alignment: .center , spacing:10) {
                    
                    Text(message)
                        .font(.DinNextArabicMedium(size: 16))
                        .multilineTextAlignment(.leading)
                    Spacer()
                    
                }
                .foregroundColor(.white)
                .padding(.vertical , 30)
                .padding(.horizontal , 20)
                .padding(.top , 35)
                
                
            }
            .background(.red)
            .offset(y : isAnimated ?  0 : -200 )
            Spacer()
        }
        .background(.black.opacity(isAnimated ? 0.3 : 0))
        .ignoresSafeArea()
        .onAppear {
            
            withAnimation(.spring().speed(0.7)){
                isAnimated = true
            }
           
            DispatchQueue.main.asyncAfter(deadline: .now() + (apearTime ?? 3 ) ){
                withAnimation(.spring().speed(0.7)){
                    isAnimated = false
                    isApear = false
                }
            }
        }
        .onTapGesture {
            withAnimation(.spring().speed(0.7)){
                isAnimated = false
                isApear = false
            }
        }
   
    }
    
    struct CustomToastView_Previews: PreviewProvider {
        static var previews: some View {
            CustomToastView( isApear:.constant(true), message: "فشل في تسجيل الدخول")
                .environment(\.layoutDirection, .rightToLeft)
            
        }
    }
}
