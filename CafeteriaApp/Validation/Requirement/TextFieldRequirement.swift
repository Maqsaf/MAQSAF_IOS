//
//  TextFieldRequirement.swift
//  EmployeeID
//
//  Created by Reenad gh on 16/07/1444 AH.
//

import Foundation

enum TextFieldRequirement : RequirementType {
    
    case isNotEmpty (filedName: String)
    case minCharacters(min: Int)
    case maxCharacters(max: Int)
    
    func fulfills(string: String) -> Bool {
        
        switch self {
        case .isNotEmpty:
            return !string.isEmpty
        case .minCharacters(min: let min):
            return string.count >= min
        case .maxCharacters(max: let max ):
            return string.count <= max
        }
        
    }
    
    var errorMessage : String {
        switch self {
        case .isNotEmpty:
            return "the text should not be empty"
        case .minCharacters(let min):
            return "the text should not be less than \(min) "
        case .maxCharacters(let max):
            return "the text should not be more than \(max)"
            
        }
    }
    
    var displayedErrorMessage : String {
        
        switch self {
        case .isNotEmpty:
            return ""
        case .minCharacters(min : _) :
            return "يجب ان يحتوي الاسم على حرفين فأكثر"
        case .maxCharacters(max : _) :
            return ""
        }
    }
}


