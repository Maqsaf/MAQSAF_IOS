//
//  LogInValidation.swift
//  EmployeeID
//
//  Created by Reenad gh on 16/07/1444 AH.
//

import Foundation

struct LogInValidation {
    
    var passwordValidations: [Validation] = []
    var employeeIdValidations : [Validation] = []
    var userNameValidations : [Validation] = []

    
    init (password : String ){
        passwordValidations = [
            Validation(string: password, validationType: TextFieldRequirement.isNotEmpty(filedName: "كلمة المرور"), field: .password),
//            Validation(string: password, validationType: PasswordRequirement.hasLowercasedLetter, field: .password) ,
//            Validation(string: password, validationType: PasswordRequirement.hasUppercasedLetter, field: .password) ,
//            Validation(string: password, validationType: PasswordRequirement.hasOneSpecialCharacters, field: .password) ,
//            Validation(string: password, validationType: PasswordRequirement.hasOneDigit, field: .password),
            Validation(string: password, validationType: PasswordRequirement.minCharacters(min: 6), field: .password)
            
        ]
    }
    
    init(employeeId: String) {
        
        employeeIdValidations = [
            Validation(string: employeeId, validationType: TextFieldRequirement.isNotEmpty(filedName: "الرقم الوظيفي"), field: .employeeId) ,
            Validation(string: employeeId, validationType: EmployeeIDRequirement.isStartWith4or9, field: .employeeId),
            Validation(string: employeeId, validationType: EmployeeIDRequirement.rangeCharacters(min: 5, max: 6), field: .employeeId)

           
        ]
    }
    
    init(userName: String) {
        
        userNameValidations = [
         
            Validation(string: userName, validationType: TextFieldRequirement.minCharacters(min: 2), field: .employeeId)
            
        ]
    }
    
    func passwordValidation(_ responseHandler: (Validation) -> Void ) {
        
        for validation in passwordValidations {
            if validation.state == .failure {
                print (validation.requirementType.errorMessage)
                return responseHandler(validation)
            }
        }
    }
    
    
    func employeeIdValidation(_ responseHandler: (Validation) -> Void ) {
        
        for validation in employeeIdValidations {
            if validation.state == .failure {
                print (validation.requirementType.errorMessage)
                return responseHandler(validation)
            }
        }
    }
    
    
    func userNameValidation(_ responseHandler: (Validation) -> Void ) {
        
        for validation in userNameValidations {
            if validation.state == .failure {
                print (validation.requirementType.errorMessage)
                return responseHandler(validation)
            }
        }
    }
}
