//
//  InputView+.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 21.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit
import ReusableDataInput

public extension InputView
{
    class func setupAppearance(forInputView inputView: InputView)
    {
        let primaryColor = UIColor.brandGrey
        let backgroundColor = UIColor.InputView.background
        
        inputView.normalColor = primaryColor
        inputView.normalImageColor = primaryColor
        inputView.normalBackgroundColor = backgroundColor
        inputView.normalBorder = 0
        
        inputView.activeColor = primaryColor
        inputView.activeImageColor = primaryColor
        inputView.activeBackgroundColor = backgroundColor
        inputView.activeBorder = 0
        
        inputView.errorColor = .warning
        inputView.errorBackgroundColor = backgroundColor
        inputView.errorMsgBackground = backgroundColor
        inputView.errorMsgColor = .warning
        inputView.errorImage = nil
        
        inputView.infoColor = primaryColor
        inputView.infoBackgroundColor = backgroundColor
        inputView.infoMsgBackground = backgroundColor
        inputView.infoMsgColor = primaryColor
        
        let fontSize: FontSize
        if UIDevice.current.type == .iPhone4OrLess || UIDevice.current.type == .iPhone5 {
            fontSize = .h5
        } else {
            fontSize = .h4
        }
        
        inputView.normalTextColor = .textPrimaryDark
        inputView.font = UIFont.brand(font: .medium, withSize: fontSize)
        inputView.placeholderFont = UIFont.brand(font: .medium, withSize: fontSize)
        
        inputView.titleColor = UIColor.InputView.title
        inputView.titleFont = UIFont.brand(font: .medium, withSize: .h8)
        inputView.cornerRadius = 0
        inputView.messageFont = UIFont.brand(font: .regular, withSize: .h7)
        
        inputView.separatorColor = UIColor.InputView.separator
        inputView.separatorHeight = 1
        inputView.isSeparatorHidden = false
    }
}
