//
//  Binding+Extention.swift
//  EmployeeID
//
//  Created by Reenad gh on 18/07/1444 AH.
//

import Foundation
import SwiftUI
import UIKit
extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}


