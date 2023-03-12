//
//  LoginValidationTestingView.swift
//  
//
//  Created by Reenad gh on 16/07/1444 AH.
//

import SwiftUI

struct LoginValidationTestingView: View {
    
    @State var password : String = ""
    @State var employeeId : String = ""
    
    var passwordValidation : [Validation] {
        
        return LogInValidation.init(password: password).passwordValidations
    }
    
    var employeeIdValidation : [Validation] {
        
        return LogInValidation.init(employeeId: employeeId).employeeIdValidations
    }
    
    
    var body: some View {
    
        VStack (alignment: .leading){
            Text("LogIn Validation UI Check ")
                .font(.largeTitle)
            TextField("Password", text: $password)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 2).stroke())
            ForEach( passwordValidation ) { validation in
                HStack {
                    Text(validation.requirementType.errorMessage)
                        .foregroundColor(validation.state == .success ? .green : .red)
                }
            }
            
            TextField("EmployeId", text: $employeeId)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 2).stroke())
            ForEach( employeeIdValidation ) { validation in
                HStack {
                    Text(validation.requirementType.errorMessage)
                        .foregroundColor(validation.state == .success ? .green : .red)
                }
            }
        }
        .padding()
    }
}

struct LoginValidationTestingView_Previews: PreviewProvider {
    static var previews: some View {
        LoginValidationTestingView()
    }
}
