//
//  SignUpView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 04/08/1444 AH.
//

import SwiftUI

struct SignUpView: View {
    @State var emplyeeId : String = ""
    @State var password : String = ""
    @State var employeeName : String = ""
    @EnvironmentObject var authViewModel : AuthViewModel
    @State var isValidInfo : Bool = false

    var isValidEntring : Bool {
        
        return LogInValidation.init(userName: employeeName ).userNameValidations.filter({$0.state == .failure}).isEmpty
        &&
        
        LogInValidation.init(employeeId: emplyeeId).employeeIdValidations.filter({$0.state == .failure}).isEmpty

        &&
        
        LogInValidation.init(password:  password).passwordValidations.filter({$0.state == .failure}).isEmpty
    
    }
    var body: some View {
        StartTempleteView(content:
                            
            VStack (alignment: .leading, spacing : 30){
            
            Text("التسجيل")
                .font(.DinNextArabicBold(size: 30))
                .foregroundColor(Color("ncgr-blue"))
                .padding(.leading , 30)
            
            VStack (spacing : 20) {
                UserNameTextFiledValidation(text: $employeeName, isValidInfo: $isValidInfo)
                
                
                EmployeeIdTextFiledValidation(text: $emplyeeId, isValidInfo:  $isValidInfo)
                
                
                PasswordTextFiledValidation(text: $password, isValidInfo:  $isValidInfo)
                
                
            }
            Button {
                authViewModel.signUp(employeeId: emplyeeId, password: password, userName: employeeName)
            } label: {
                Text("تسجيل جديد")
                    .font(.DinNextArabicBold(size: 17))
                    .foregroundColor(.white)
                    .frame( maxWidth : .infinity , alignment: .center)
                    .padding(.vertical , 14)
                    .background(isValidEntring ? Color("ncgr-blue") : .gray)
                    .cornerRadius(15)
                    .padding(.horizontal ,25)
                
            }
            .disabled(!isValidEntring)
            .frame( maxWidth : .infinity , alignment: .center)
            .padding(.top)
            
            
        }
                          
            .padding(.vertical)
                          
        )
    
        .animation(.easeInOut(duration: 0.7))
            .dismissKeyboard(on: [.drag, .tap])
            .ignoresSafeArea()
        
            .overlay(
                ZStack {
                    
                    if authViewModel.isloading {
                        NCGRProgressView()
                    } else if authViewModel.error {
                        
                        CustomToastView( isApear: $authViewModel.error, message: authViewModel.errorMessage)

                    }
                    
                }
            )
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthViewModel())
    }
}
