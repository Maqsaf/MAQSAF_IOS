//
//  String+Extention.swift
//  EmployeeID
//
//  Created by Reenad gh on 15/07/1444 AH.
//

import Foundation
import SwiftUI


extension String {

    func hasUppercasedCharacters() -> Bool {
        return stringFulfillsRegex(regex:  ".*[A-Z]+.*")
    }

    func hasLowercasedCharacters() -> Bool {
        return stringFulfillsRegex(regex: ".*[a-z]+.*")
    }
    
    func hasOneDigit() -> Bool {
        return stringFulfillsRegex(regex: ".*[0-9]+.*")
    }
    
    func hasOneSpecialCharacters() -> Bool {
        return stringFulfillsRegex(regex: ".*[!&^%$#@()/_*+-.,?']+.*")
    }
    
    var isNumber: Bool {
        return stringFulfillsRegex(regex: "^[0-9]+$")
     }
    
    private func stringFulfillsRegex(regex: String) -> Bool {
        let texttest = NSPredicate(format: "SELF MATCHES %@", regex)
        guard texttest.evaluate(with: self) else {
            return false
        }
        return true
    }
}
