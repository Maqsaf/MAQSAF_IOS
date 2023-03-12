//
//  ValidationType.swift
//  EmployeeID
//
//  Created by Reenad gh on 16/07/1444 AH.
//

import Foundation

enum ValidationState {
    case success
    case failure
}

enum Field: String {
    case employeeId
    case password
}

struct Validation  : Identifiable {
    
    let id = UUID()
    var requirementType: RequirementType
    var state: ValidationState
    var field: Field

    init(string: String, validationType: RequirementType , field : Field) {
        self.requirementType = validationType
        self.state = validationType.fulfills(string: string) ? .success : .failure
        self.field = field
    }
    
}
