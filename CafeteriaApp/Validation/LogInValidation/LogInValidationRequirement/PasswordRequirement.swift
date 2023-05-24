//
//  PasswordRequirement.swift
//  EmployeeID
//
//  Created by Reenad gh on 16/07/1444 AH.
//

import Foundation

enum PasswordRequirement :  RequirementType {
    
//    case hasLowercasedLetter
//    case hasUppercasedLetter
//    case hasOneDigit
//    case hasOneSpecialCharacters
    case minCharacters(min: Int)
    
    func fulfills(string: String) -> Bool {
        
        switch self {
            
//        case .hasLowercasedLetter :
//            return string.hasLowercasedCharacters()
//        case .hasUppercasedLetter :
//            return string.hasUppercasedCharacters()
//        case .hasOneDigit:
//            return string.hasOneDigit()
//        case .hasOneSpecialCharacters:
//            return string.hasOneSpecialCharacters()
        case .minCharacters(min: let min):
            return string.count >= min
            
        }
    }
    
    var errorMessage: String {
        
        switch self {
//        case .hasLowercasedLetter:
//            return "the password should contain lowercase letter"
//
//        case .hasUppercasedLetter:
//            return "the password should contain uppercase letter"
//
//        case .hasOneDigit:
//            return "the password should contain at least one number"
//
//        case .hasOneSpecialCharacters:
//            return "the password should contain at least one Special Character"
        case .minCharacters(min: let min):
            return "the password should more than \(min)"
            
        }
    }
    
    var  displayedErrorMessage: String {
        switch self {

//        case .hasLowercasedLetter:
//            return "يجب ان يحتوي على حروف صغيرة"
//        case .hasUppercasedLetter:
//            return "يجب ان يحتوي على حروف كبيرة"
//        case .hasOneDigit:
//            return "يجب ان يحتوي على رقم فأكثر"
//        case .hasOneSpecialCharacters:
//            return "يجب ان يحتوي على رموز مثل @$٪!$"

        case .minCharacters(min: _):
            return "يجب ان يحتوي الرقم السري على ٦ ارقام فأكثر"
        }
        
    }
}
