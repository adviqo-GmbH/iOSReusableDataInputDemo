//
//  TextViewDemoViewController.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 16.11.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit
import ReusableDataInput
import iOSReusableExtensions

class TextViewDemoViewController: BaseViewController
{
    // MARK: - View Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupViewsOnLoad()
    }
    
    // MARK: - Actions
    @IBAction func validateAction(_ sender: Any)
    {
        self.inputViewCollection.forEach { $0.resignFirstResponderForInputView() }
        self.inputViewCollection.forEach { $0.state = $0.validate() ? .normal : .error }
    }
    
    @IBAction func clearAction(_ sender: Any)
    {
        self.textView.set(text: nil, animated: false)
    }
    
    @IBAction func setValueAction(_ sender: Any)
    {
        // TextInput data
        do {
            self.textView.set(text: "Example text value Example text value Example text value Example text value Example text value", animated: true)
        }
    }
    
    @objc func textViewAction(sender: Any)
    {
        self.textView.set(text: nil, animated: false)
    }
    
    // MARK: - Private
    @IBOutlet weak private var textView: DesignableTextView!
    
    @IBOutlet private var buttons: [UIButton]!
    @IBOutlet private var containers: [UIView]!
    @IBOutlet private var labels: [UILabel]!
}

// MARK: - InputViewValidator
extension TextViewDemoViewController: InputViewValidator
{
    func inputView(_ inputView: InputView, shouldValidateValue perhapsValue: String?) -> Bool
    {
        guard let validationRules = inputView.validationRules else { return true }
        for validationRule in validationRules {
            if !validationRule.rule.validationHandler(perhapsValue) {
                inputView.errorMessage = validationRule.message
                return false
            }
        }
        return true
    }
}

// MARK: - TextViewDelegate
extension TextViewDemoViewController: TextViewDelegate
{
    func textViewDidBeginEditing(_ textInput: DesignableTextView)
    {
        
    }
    
    func textViewDidChange(_ textInput: DesignableTextView)
    {
        
    }
}

// MARK: - Private
extension TextViewDemoViewController
{
    private func setupViewsOnLoad()
    {
//        self.title = "Text View"
        self.view.backgroundColor = .background
        
        // buttons
        do {
            self.buttons.forEach {
                $0.backgroundColor = UIColor.Button.background
                $0.layer.cornerRadius = 8
                $0.clipsToBounds = true
                $0.titleLabel?.font = UIFont.brand(font: .regular, withSize: .h5)
                $0.setTitleColor(UIColor.Button.title, for: .normal)
            }
        }
        
        // containers
        do {
            self.containers.forEach {
                $0.backgroundColor = .white
                $0.layer.cornerRadius = 8
                $0.clipsToBounds = true
            }
        }
        
        // labels
        do {
            self.labels.forEach {
                $0.textColor = .brand
            }
        }

        // textView
        do {
            let deleteIcon = UIImage(named: "ic_delete")
            
            DesignableTextView.setupAppearance(forInputView: self.textView)
            self.textView.name = "textView"
            self.textView.title = "Text view"
            self.textView.normalImage = deleteIcon
            self.textView.activeImage = deleteIcon
            self.textView.delegate = self
            self.textView.validator = self
            self.textView.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please enter text!")
            ]
            self.textView.rightButton.isEnabled = true
            self.textView.rightButton.addTarget(self, action: #selector(self.textViewAction(sender:)), for: .touchUpInside)
            self.textView.isSeparatorHidden = true
        }
    }
}
