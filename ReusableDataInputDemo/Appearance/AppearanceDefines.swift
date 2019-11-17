//
//  AppearanceDefines.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 21.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit

@objc public extension UIColor
{
    static let brand = UIColor(hex: "681E5A")
    static let textPrimaryDark = UIColor(hex: "343562")
    static let warmGrey = UIColor(hex: "A0A0A0")
    static let brandGrey = UIColor(hex: "8D9194")
    static let lightGrey = UIColor(hex: "C8C7CC")
    static let brandGreen = UIColor(hex: "0EBBB3")
    static let warning = UIColor(hex: "D0011A")
    
    static let background = UIColor(hex: "F1F5FB")
//    static let textBlack = UIColor(hex: "333333")
}

// MARK: - UIButton
extension UIColor {
    enum Button
    {
        static let background = UIColor.brandGreen
        static let title = UIColor.white
    }
}

// MARK: - InputView
extension UIColor {
    enum InputView
    {
        static let background = UIColor.white
        static let title = UIColor.warmGrey
        static let separator = UIColor.lightGrey
    }
}
