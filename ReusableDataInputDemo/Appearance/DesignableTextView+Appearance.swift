//
//  DesignableTextView+Appearance.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 16.11.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit
import ReusableDataInput

public extension DesignableTextView
{
    class func setupAppearance(forTextView textView: DesignableTextView)
    {
        InputView.setupAppearance(forInputView: textView)
        
        textView.keyboardType = .default
        textView.textView.autocorrectionType = .no
        textView.textView.spellCheckingType = .no
        textView.textView.autocapitalizationType = .none
        textView.textView.returnKeyType = .next
    }
}
