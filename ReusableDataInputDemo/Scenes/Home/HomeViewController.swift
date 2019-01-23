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
        self.firstNameTextInput.set(text: nil, animated: true)
        self.lastNameTextInput.set(text: nil, animated: true)
        self.pickerView.value = nil
        self.datePickerView.set(date: nil, animated: true)
        self.genderPicker.value = nil
    }
    
    @IBAction func setValueAction(_ sender: Any)
    {
        self.textInput.set(text: "Example text value", animated: true)
        self.firstNameTextInput.set(text: "Sandra", animated: true)
        self.lastNameTextInput.set(text: "Gutierrez", animated: true)
        
        self.pickerView.value = self.pickerDataSource[1]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: "1975-10-06 01:01:01") as NSDate? {
            self.datePickerView.set(date: date, animated: true)
        }
        
        self.genderPicker.value = self.genderDataSource[0].title
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
    @IBOutlet weak fileprivate var firstNameTextInput: DesignableTextInput!
    @IBOutlet weak fileprivate var lastNameTextInput: DesignableTextInput!
    
    @IBOutlet weak fileprivate var pickerView: DesignablePicker!
    @IBOutlet weak fileprivate var datePickerView: DesignableDatePicker!
    @IBOutlet weak fileprivate var genderPicker: DesignablePicker!
    
    @IBOutlet fileprivate var buttons: [UIButton]!
    @IBOutlet fileprivate var containers: [UIView]!
    
    let pickerDataSource = "Orange, Green, Blue, Red".components(separatedBy: ",").map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
    let genderDataSource = [Gender.female, Gender.male]
    
    enum Gender: String
    {
        case female
        case male
        
        var title: String {
            switch self {
            case .female: return "Female"
            case .male: return "Male"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .female: return UIImage(named: "ic_male")
            case .male: return UIImage(named: "ic_female")
            }
        }
    }
    
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
            self.textInput.name = "textInput"
            self.textInput.title = "Text input"
            self.textInput.normalImage = infoInactiveImage
            self.textInput.normalImageColor = .brand
            self.textInput.activeImage = infoInactiveImage
            self.textInput.activeImageColor = .brand
            self.textInput.infoImage = infoActiveImage
            self.textInput.infoImageColor = .brand
            self.textInput.delegate = self
            self.textInput.validator = self
            self.textInput.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please enter text!")
            ]
            self.textInput.rightButton.isEnabled = true
            self.textInput.rightButton.addTarget(self, action: #selector(self.textInputInfoAction(sender:)), for: .touchUpInside)
            self.textInput.infoMessage = "Information for better understanding what is required from user within a process."
        }
        
        // firstNameTextInput
        do {
            DesignableTextInput.setupAppearance(forTextInput: self.firstNameTextInput)
            self.firstNameTextInput.name = "firstNameTextInput"
            self.firstNameTextInput.title = "First name"
            self.firstNameTextInput.delegate = self
            self.firstNameTextInput.validator = self
            self.firstNameTextInput.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please enter first name!")
            ]
            self.firstNameTextInput.leftImage = UIImage(named: "ic_person")
        }
        
        // lastNameTextInput
        do {
            DesignableTextInput.setupAppearance(forTextInput: self.lastNameTextInput)
            self.lastNameTextInput.name = "lastNameTextInput"
            self.lastNameTextInput.title = "Last name"
            self.lastNameTextInput.delegate = self
            self.lastNameTextInput.validator = self
            self.lastNameTextInput.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please enter last name!")
            ]
            self.lastNameTextInput.leftImage = UIImage(named: "ic_person")
            self.lastNameTextInput.isSeparatorHidden = true
        }
        
        // pickerView
        do {
            DesignablePicker.setupAppearance(forPicker: self.pickerView)
            self.pickerView.data = self.pickerDataSource
            self.pickerView.delegate = self
            self.pickerView.validator = self
            self.pickerView.name = "pickerView"
            self.pickerView.title = "Picker"
            self.pickerView.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please select picker value!")
            ]
        }
        
        // genderPicker
        do {
            DesignablePicker.setupAppearance(forPicker: self.genderPicker)
            self.genderPicker.data = self.genderDataSource.map { $0.title }
            self.genderPicker.delegate = self
            self.genderPicker.validator = self
            self.genderPicker.name = "genderPicker"
            self.genderPicker.title = "Gender"
            self.genderPicker.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please select gender!")
            ]
            self.genderPicker.leftImage = UIImage(named: "ic_gender")
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
        
        if picker == self.genderPicker {
            print("[\(type(of: self)) \(#function)] value: \(value) index: \(index)")
            picker.leftImage = self.genderDataSource[index].icon
            return
        }
    }
    
    func pickerInputDidCancel(_ picker: DesignablePicker)
    {
        print("[\(type(of: self)) \(#function)]")
    }
    
    func pickerInput(_ picker: DesignablePicker, titleForRow row: Int) -> String?
    {
        if picker == self.pickerView {
            return self.pickerDataSource[row]
        }
        if picker == self.genderPicker {
            return self.genderDataSource[row].title
        }
        return nil
    }
    
    func pickerInput(_ picker: DesignablePicker, viewForRow row: Int, reusing view: UIView?) -> UIView?
    {
        if picker == self.genderPicker {
            let itemView: CustomItemPickerView
            if let view = view {
                itemView = view as! CustomItemPickerView
            } else {
                itemView = CustomItemPickerView.loadNib()
                itemView.titleLabel.font = picker.pickerFont
                itemView.titleLabel.textColor = picker.pickerTextColor
            }
            guard row < self.genderDataSource.count else {
                return nil
            }
            itemView.titleLabel.text = self.genderDataSource[row].title
            itemView.iconImageView.image = self.genderDataSource[row].icon
            return itemView
        }
        
        return nil
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
