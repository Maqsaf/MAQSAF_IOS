//
//  NCGRColor.swift
//  NCGRSwiftUITemplate
//
//  Created by toc on 22/01/2023.
//

import SwiftUI
import UIKit

// Getting Colors from assets
enum AssetsColor: String {
    case background
    case background50
    case bluishDarkGray
    case bluishGrayX
    case bluishGray
    case DarkGray
    case pure
    case pureX
    case separator
    case shadow
    case vibrant
    case vibrantX
    case White
    case darkBlue
    case darkPurple
    case lightGreen
    case lightGray
}

extension Color {
    static func appColor(_ name: AssetsColor, opacity: CGFloat = 1.0) -> Color {
        return Color(name.rawValue).opacity(opacity)
    }
}
