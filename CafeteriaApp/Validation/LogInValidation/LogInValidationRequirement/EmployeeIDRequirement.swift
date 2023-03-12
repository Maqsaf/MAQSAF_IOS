//
//  EmployeeIDRequirement.swift
//  EmployeeID
//
//  Created by Reenad gh on 16/07/1444 AH.
//

import Foundation

enum EmployeeIDRequirement : RequirementType {
    
    case isNumber
    case isStartWith4or9
    case rangeCharacters(min: Int , max : Int )

    func fulfills(string: String) -> Bool {
        
        switch self {
        case .isNumber:
            return string.isNumber
        case .isStartWith4or9:
            return (Int(string.prefix(1)) ?? 0 != 0)
        case .rangeCharacters(min: let min , max : let max ):
            return string.count >= min && string.count <= max
 
        }
    }
    
    var errorMessage: String {
        switch self {
        case .isNumber:
            return "the Employee ID should be numbers"
            
        case .isStartWith4or9:
            return "the Employee ID shouldn't start with nubmer 0 "
        case .rangeCharacters(min: _, max: _) :
            return "يجب ان يتكون الرقم الوظيفي من 5-6 ارقام"
        }
    }
    
    var  displayedErrorMessage: String {
        switch self {
        case .isNumber:
            return ""
        case .isStartWith4or9:
            return "يجب ان لا يبدأ الرقم الوظيفي بـ 0"
        case .rangeCharacters(min: _, max: _) :
            return "يجب ان يتكون الرقم الوظيفي من 5-6 ارقام"
        }
    }
    
}
