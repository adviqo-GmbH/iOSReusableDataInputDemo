//
//  HomeViewController.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 17.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit
import ReusableDataInput
import iOSReusableExtensions

class HomeViewController: BaseViewController
{
    // MARK: - Public
    
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
        self.textInput.set(text: nil, animated: true)
        self.pickerView.value = nil
        self.datePickerView.set(date: nil, animated: true)
    }
    
    @IBAction func setValueAction(_ sender: Any)
    {
        self.textInput.set(text: "Sandra", animated: true)
        
        self.pickerView.value = self.dataSource[1]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: "1975-10-06 01:01:01") as NSDate? {
            self.datePickerView.set(date: date, animated: true)
        }
    }
    
    @objc fileprivate func textInputInfoAction(sender: UIButton)
    {
        if self.textInput.isFirstResponder {
            self.textInput.resignFirstResponderForInputView()
        }
        self.textInput.state = (self.textInput.state == .normal) ? .info : .normal
    }
    
    // MARK: - Private
    @IBOutlet weak fileprivate var textInput: DesignableTextInput!
    @IBOutlet weak fileprivate var pickerView: DesignablePicker!
    @IBOutlet weak fileprivate var datePickerView: DesignableDatePicker!
    
    @IBOutlet fileprivate var buttons: [UIButton]!
    @IBOutlet fileprivate var containers: [UIView]!
    
    let dataSource = "Orange, Green, Blue, Red".components(separatedBy: ",")
    
    internal func setupViewsOnLoad()
    {
        self.title = "Reusable Data Input Demo"
        self.view.backgroundColor = .brand
        
        // buttons
        self.buttons.forEach {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
            $0.titleLabel?.font = UIFont.brand(font: .regular, withSize: .h5)
            $0.setTitleColor(.textPrimaryDark, for: .normal)
        }
        
        // containers
        self.containers.forEach {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
        
        let infoInactiveImage = UIImage(named: "infoInactive")
        let infoActiveImage = UIImage(named: "infoActive")
        
        // textInput
        do {
            DesignableTextInput.setupAppearance(forTextInput: self.textInput)
            self.textInput.name = "firstName"
            self.textInput.title = "First name"
            self.textInput.normalImage = infoInactiveImage
            self.textInput.normalImageColor = .brand
            self.textInput.activeImage = infoInactiveImage
            self.textInput.activeImageColor = .brand
            self.textInput.infoImage = infoActiveImage
            self.textInput.infoImageColor = .brand
            self.textInput.delegate = self
            self.textInput.validator = self
            self.textInput.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please enter first name!")
            ]
            self.textInput.rightButton.isEnabled = true
            self.textInput.rightButton.addTarget(self, action: #selector(self.textInputInfoAction(sender:)), for: .touchUpInside)
            self.textInput.infoMessage = "Information for better understanding what is required from user within a process."
            self.textInput.leftImage = UIImage(named: "ic_person")
            self.textInput.isSeparatorHidden = true
        }
        
        // pickerView
        do {
            DesignablePicker.setupAppearance(forPicker: self.pickerView)
            self.pickerView.data = self.dataSource
            self.pickerView.delegate = self
            self.pickerView.validator = self
            self.pickerView.name = "pickerView"
            self.pickerView.title = "Picker"
            self.pickerView.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please select picker value!")
            ]
        }
        
        // datePickerView
        do {
            DesignableDatePicker.setupAppearance(forDatePicker: self.datePickerView)
            self.datePickerView.delegate = self
            self.datePickerView.validator = self
            self.datePickerView.name = "datePickerView"
            self.datePickerView.title = "Date picker"
            self.datePickerView.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please select date picker value!")
            ]
            self.datePickerView.isSeparatorHidden = true
        }
    }
}

// MARK: - TextInputDelegate
extension HomeViewController: TextInputDelegate
{
    func textInputDidChange(_ textInput: DesignableTextInput)
    {
//        print("[\(type(of: self)) \(#function)]")
    }
    
    func textInputShouldReturn(_ textInput: DesignableTextInput) -> Bool
    {
        if let nextInput = textInput.nextInput {
            nextInput.becomeFirstResponderForInputView()
        } else {
            textInput.resignFirstResponderForInputView()
        }
        return true
    }
    
    func textInputDidBeginEditing(_ textInput: DesignableTextInput)
    {
        print("[\(type(of: self)) \(#function)]")
    }
    
    func textInputDidEndEditing(_ textInput: DesignableTextInput)
    {
        print("[\(type(of: self)) \(#function)]")
    }
}

// MARK: - PickerInputDelegate
extension HomeViewController: PickerInputDelegate
{
    func pickerInput(_ picker: DesignablePicker, doneWithValue value: String, andIndex index: Int)
    {
        if picker == self.pickerView {
            print("[\(type(of: self)) \(#function)] value: \(value) index: \(index)")
            return
        }
    }
    
    func pickerInputDidCancel(_ picker: DesignablePicker)
    {
        print("[\(type(of: self)) \(#function)]")
    }
    
    func pickerInput(_ picker: DesignablePicker, titleForRow row: Int) -> String
    {
        if picker == self.pickerView {
            return self.dataSource[row]
        }
        return ""
    }
}

// MARK: - DatePickerInputDelegate
extension HomeViewController: DatePickerInputDelegate
{
    func datePickerInput(_ picker: DesignableDatePicker, doneWithDate date: NSDate)
    {
        if picker == self.datePickerView {
            print("[\(type(of: self)) \(#function)] date: \(date)")
            return
        }
    }
    
    func datePickerInputDidCancel(_ picker: DesignableDatePicker)
    {
        print("[\(type(of: self)) \(#function)]")
    }
}

// MARK: - InputViewValidator
extension HomeViewController: InputViewValidator
{
    func inputView(_ inputView: InputView, shouldValidateValue perhapsValue: String?) -> Bool
    {
        guard let validationRules = inputView.validationRules else {
            return true
        }
        for validationRule in validationRules {
            if !validationRule.rule.validationHandler(perhapsValue) {
                inputView.errorMessage = validationRule.message
                return false
            }
        }
        return true
    }
}
