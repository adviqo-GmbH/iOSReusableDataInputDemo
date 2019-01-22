//
//  DesignablePicker+Appearance.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 22.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit
import ReusableDataInput

public extension DesignablePicker
{
    public class func setupAppearance(forPicker picker: DesignablePicker)
    {
        DesignablePicker.setupAppearance(forInputView: picker)
        
        picker.toolbarBackgroundColor = .backgroundLight
        picker.pickerColor = .brand
        picker.pickerTextColor = .textPrimaryDark
        
        picker.pickerFont = UIFont.brand(font: .regular, withSize: .h4)
        picker.cancelButton.title = "Cancel"
        picker.doneButton.title = "Done"
        
        let pickerArrow = UIImage(named: "pickerArrow")
        picker.normalImage = pickerArrow
        picker.activeImage = pickerArrow
    }
}
