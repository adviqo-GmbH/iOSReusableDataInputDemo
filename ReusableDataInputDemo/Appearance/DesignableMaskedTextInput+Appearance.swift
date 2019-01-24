//
//  DesignableMaskedTextInput+Appearance.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 23.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit
import ReusableDataInput

public extension DesignableMaskedTextInput
{
    public class func setupAppearance(forTextInput textInput: DesignableMaskedTextInput)
    {
        DesignableTextInput.setupAppearance(forInputView: textInput)
    }
}
