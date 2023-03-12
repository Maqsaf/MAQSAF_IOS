//
//  OnBoardingView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 28/07/1444 AH.
//

import SwiftUI

struct AuthView: View {
    
    @State var isUserInitlized : Bool = false
    @State var isTeaBoy : Bool =  false
    @State var isShowLogIn : Bool = false
    @State var isShowSignUp : Bool = false
    
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        NavigationStack {
            
            LogInView()
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}




struct NCGRCustomButtonLabel: View {
    var imgName : String
    var descreption : String
    
    var body: some View {
        HStack (spacing : 20){
            
            Image(imgName)
            Text(descreption)
            .foregroundColor(Color("ncgr-purple"))
            Spacer()
        }
        .padding(.horizontal , 20)
        .padding(.vertical , 10)
        .background(.white)
        .cornerRadius(20)
        .shadow(color : Color.black.opacity(0.05) , radius: 1 , x: 0 , y : 6)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(.black).opacity(0.5)
                 
        )
        .padding(.horizontal , 35)
    }
}

struct UserCustomTextFiled: View {
    @Binding var text : String
    var titleKey : String
    var imgText : String
    
    var body: some View {
        
        
        HStack (spacing : 20){
            
            
            Image(systemName: imgText)
                .foregroundColor(Color("ncgr-yellow"))
            
            TextField(titleKey, text: $text)
            
                .foregroundColor(Color("ncgr-purple"))
            Spacer()
        }
        .padding(.horizontal , 20)
        .padding(.vertical , 20)
        
        .background(.white)
        .cornerRadius(20)
        .shadow(color : Color.black.opacity(0.05) , radius: 1 , x: 0 , y : 6)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(.black).opacity(0.5)
                 
        )
        .padding(.horizontal , 35)
        
        
        
        
        
    }
}


struct EmployeeIdTextFiled: View {
    @Binding var text : String
    var titleKey : String
    var imgText : String
    
    var body: some View {
        
        
        HStack (spacing : 20){
            
            
            Image("office-worker")
                .resizable()
                .scaledToFit()
                .frame(width: 20)
            
            
            SecureField(titleKey, text: $text)
            
                .foregroundColor(Color("ncgr-purple"))
            Spacer()
        }
        .padding(.horizontal , 20)
        .padding(.vertical , 20)
        
        .background(.white)
        .cornerRadius(20)
        .shadow(color : Color.black.opacity(0.05) , radius: 1 , x: 0 , y : 6)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(.black).opacity(0.5)
                 
        )
        .padding(.horizontal , 35)
        
        
        
        
        
    }
}


struct SecureCustomTextFiled: View {
    @Binding var text : String
    var titleKey : String
    var imgText : String
    
    var body: some View {
        
        
        HStack (spacing : 20){
            
            
            Image(systemName: imgText)
                .foregroundColor(Color("ncgr-yellow"))
            
            
            
            SecureField(titleKey, text: $text)
            
                .foregroundColor(Color("ncgr-purple"))
            Spacer()
        }
        .padding(.horizontal , 20)
        .padding(.vertical , 20)
        
        .background(.white)
        .cornerRadius(20)
        .shadow(color : Color.black.opacity(0.05) , radius: 1 , x: 0 , y : 6)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(.black).opacity(0.5)
                 
        )
        .padding(.horizontal , 35)
        
        
        
        
        
    }
}

struct StartView: View {
    
    @Binding var isTeaBoy : Bool
    @Binding var isUserInitlized : Bool
    var body: some View {
        
        NavigationStack{
            StartTempleteView(content:
                                
            VStack(spacing : 60){

                VStack (alignment: .leading, spacing : 20){
                    Text("مرحبا بك في مقصف")
                        .font(.DinNextArabicMedium(size: 20))
                    .foregroundColor(Color("ncgr-blue"))
                    Text("قم بالانضمام معنا كـ :")
                     .font(.DinNextArabicMedium(size: 14))
                     .foregroundColor(Color("ncgr-blue"))
                }
                .padding(.leading , 50)
                .frame(maxWidth: .infinity , alignment: .leading)
                
                HStack (spacing : 30){
                    NavigationLink {
                        LogInView()
                        
                    }label: {
                        
                        VStack (spacing : 0){
                            Image("employee")
                                .padding(35)
                                .frame(width: 120 , height: 120)
                                .background(Color("ncgr-white"))
                                .cornerRadius(7)

                            Text("موظف")
                                .font(.DinNextArabicMedium(size: 17))
                                .foregroundColor(.white)
                                .frame(width: 120 , height: 50)
                            
                        }
                        .background(Color("ncgr-blue"))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.15), radius: 10)
                        
                    }
//                    NavigationLink {
//
//                    }label: {
//                        VStack (spacing : 0){
//                            Image("provider")
//                                .padding(35)
//                                .frame(width: 120 , height: 120)
//                                .background(Color("ncgr-white"))
//                                .cornerRadius(7)
//
//                            Text("مزود خدمة")
//                                .font(.DinNextArabicMedium(size: 17))
//                                .foregroundColor(.white)
//                                .frame(width: 120 , height: 50)
//
//                        }
//                        .background(Color("ncgr-blue"))
//                        .cornerRadius(12)
//                        .shadow(color: Color.black.opacity(0.15), radius: 10)
//
//                    }
                }
            }
        
            )
        }
    }
}




