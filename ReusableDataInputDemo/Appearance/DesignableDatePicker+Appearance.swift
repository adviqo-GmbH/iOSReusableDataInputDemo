//
//  DesignableDatePicker+Appearance.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 22.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit
import ReusableDataInput

public extension DesignableDatePicker
{
    class func setupAppearance(forDatePicker picker: DesignableDatePicker)
    {
        DesignableDatePicker.setupAppearance(forInputView: picker)
        
        picker.toolbarBackgroundColor = UIColor.InputView.background
        picker.pickerColor = .brand
        
        picker.cancelButton.title = "Cancel"
        picker.doneButton.title = "Done"

        let calendarImage = UIImage(named: "calendar")
        picker.normalImage = calendarImage
        picker.activeImage = calendarImage
    }
}
