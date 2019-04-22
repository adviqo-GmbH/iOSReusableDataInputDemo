//
//  DesignableMonthYearPicker+Appearance.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 23.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit
import ReusableDataInput

public extension DesignableMonthYearPicker
{
    class func setupAppearance(forPicker inputView: DesignableMonthYearPicker)
    {
        DesignableTextInput.setupAppearance(forInputView: inputView)
        
        inputView.toolbarBackgroundColor = .backgroundLight
        inputView.pickerColor = .brand
        inputView.pickerTextColor = .textPrimaryDark
        
        inputView.pickerFont = UIFont.brand(font: .regular, withSize: .h4)
        inputView.cancelButton.title = "Cancel"
        inputView.doneButton.title = "Done"
    }
}
