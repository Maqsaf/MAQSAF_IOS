//
//  Font+Extention.swift
//  NCGRCards
//
//  Created by Reenad gh on 04/07/1444 AH.
//

import Foundation
import SwiftUI

extension Font {
    
    static func DinNextArabicBold(size : CGFloat) -> Font {
        return Font.custom(Constants.FontsName.dinNextArabic.bold.rawValue, size: size)
    }
    
    static func DinNextArabicRegular(size : CGFloat) -> Font {
        return Font.custom(Constants.FontsName.dinNextArabic.regular.rawValue, size: size)
    }
    
    static func DinNextArabicMedium(size : CGFloat) -> Font {
       return Font.custom(Constants.FontsName.dinNextArabic.medium.rawValue, size: size)
    }
    
    static func DinNextArabicLight(size : CGFloat) -> Font {
       return Font.custom(Constants.FontsName.dinNextArabic.light.rawValue, size: size)
    }
}

