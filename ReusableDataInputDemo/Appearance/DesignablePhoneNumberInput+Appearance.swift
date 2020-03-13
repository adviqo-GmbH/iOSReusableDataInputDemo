//
//  DesignablePhoneNumberInput+Appearance.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 13.03.20.
//  Copyright © 2020 adviqo. All rights reserved.
//

import Foundation
import ReusableDataInput

public extension DesignablePhoneNumberInput {
    class func setupAppearance(forPhoneNumberInput textInput: DesignablePhoneNumberInput) {
        DesignableTextInput.setupAppearance(forInputView: textInput)
    }
}
