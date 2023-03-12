//
//  LogInView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 05/08/1444 AH.
//

import SwiftUI

struct LogInView : View {
    @State var emplyeeId : String = ""
    @State var password : String = ""
    @State var isValidInfo : Bool = false
    @EnvironmentObject var authViewModel : AuthViewModel

    var isValidEntring : Bool {
        
        LogInValidation.init(employeeId: emplyeeId).employeeIdValidations.filter({$0.state == .failure}).isEmpty
        &&
        LogInValidation.init(password:  password).passwordValidations.filter({$0.state == .failure}).isEmpty
    }
    
    var body: some View {
        
        NavigationStack{
            StartTempleteView(content:
                                
            VStack (alignment: .leading, spacing : 35){
                Text("تسجيل الدخول")
                    .font(.DinNextArabicBold(size: 30))
                    .foregroundColor(Color("ncgr-blue"))
                    .padding(.leading , 30)
                
                VStack{
                    
                    EmployeeIdTextFiledValidation(text: $emplyeeId, isValidInfo:  $isValidInfo)
                    
                    PasswordTextFiledValidation(text: $password, isValidInfo:  $isValidInfo)
                }

                VStack (spacing : 15){
                    
                    Button {
                        authViewModel.logIn(employeeId: emplyeeId, password: password)
                    } label: {
                        Text("تسجيل الدخول")
                            .font(.DinNextArabicBold(size: 17))
                            .foregroundColor(.white)
                            .frame( maxWidth : .infinity , alignment: .center)
                            .padding(.vertical , 14)
                            .background(isValidEntring ? Color("ncgr-blue") : .gray)
                            .cornerRadius(15)
                            .padding(.horizontal ,40)
                        
                    }
                    .disabled(!isValidEntring)
                    .frame( maxWidth : .infinity , alignment: .center)
                    .padding(.top)
                    
                    
                    NavigationLink {
                        
                        SignUpView()
                        
                    } label: {
                        Text("تسجيل جديد")
                            .font(.DinNextArabicBold(size: 17))
                            .foregroundColor(.white)
                            .frame( maxWidth : .infinity , alignment: .center)
                            .padding(.vertical , 14)
                            .background(Color.appColor(.darkBlue))
                            .cornerRadius(15)
                            .padding(.horizontal ,40)
 
                    }
                }
                .padding(.top)
                
                
            }
                              
            )
            .dismissKeyboard(on: [.drag, .tap])
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
}


struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .environmentObject(AuthViewModel())
    }
}
