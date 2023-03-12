//
//  RequirementType.swift
//  EmployeeID
//
//  Created by Reenad gh on 16/07/1444 AH.
//

import Foundation

protocol RequirementType  {
    
    func fulfills(string: String) -> Bool
    var errorMessage : String { get }
    var displayedErrorMessage : String {get}
    }
    


