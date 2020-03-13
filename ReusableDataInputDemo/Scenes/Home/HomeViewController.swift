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
import SwiftLuhn

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
        /*
        self.inputViewCollection.forEach {
            let result = $0.validate()
            if !result {
                print("[\(type(of: self)) \(#function)] name: \(String(describing: $0.name)) result: \(result) message: \($0.errorMessage)")
            }
            $0.state = result ? .normal : .error
        }
        */
    }
    
    @IBAction func clearAction(_ sender: Any)
    {
        self.textInput.set(text: nil, animated: false)
        self.firstNameTextInput.set(text: nil, animated: false)
        self.lastNameTextInput.set(text: nil, animated: false)
        
        self.pickerView.value = nil
        self.datePickerView.set(date: nil, animated: false)
        self.genderPicker.value = nil
        
        self.cardNumberTextInput.value = nil
        self.cardValidTillDatePicker.set(text: nil, animated: false)
        self.cardCVVTextInput.value = nil
    }
    
    @IBAction func setValueAction(_ sender: Any)
    {
        // TextInput data
        do {
            self.textInput.set(text: "Example text value", animated: false)
            self.firstNameTextInput.set(text: "Sandra", animated: false)
            self.lastNameTextInput.set(text: "Gutierrez", animated: false)
        }
        
        // Picker
        self.pickerView.value = self.pickerDataSource[1]
        
        // datePickerView
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: "1975-10-06 01:01:01") as NSDate? {
                self.datePickerView.set(date: date, animated: false)
            }
        }
        
        // genderPicker
        self.genderPicker.value = self.genderDataSource[0].title
        
        // Card data
        do {
            //        self.cardNumberTextInput.value = "5454545454545454"
            //        self.cardNumberTextInput.value = "378282246310005"
            self.cardNumberTextInput.value = "5232249011576818"
            self.cardValidTillDatePicker.set(month: 06, andYear: 2021, animated: false)
            self.cardCVVTextInput.value = "333"
        }
    }
    
    @objc fileprivate func textInputInfoAction(sender: UIButton)
    {
        if self.textInput.isFirstResponder {
            self.textInput.resignFirstResponderForInputView()
        }
        self.textInput.state = (self.textInput.state == .normal) ? .info : .normal
    }
    
    @objc fileprivate func cardCVVButtonAction(sender: UIButton)
    {
        if self.cardCVVTextInput.isFirstResponder {
            self.cardCVVTextInput.resignFirstResponderForInputView()
        }
        self.cardCVVTextInput.state = (self.cardCVVTextInput.state == .normal) ? .info : .normal
    }
    
    @IBAction func scrollAction(_ sender: Any)
    {
        guard let scrollView = self.view.scrollView else {
            return
        }
        let currentFrame = scrollView.convert(self.cardNumberTextInput.bounds, from: self.cardNumberTextInput)
        scrollView.scrollRectToVisible(currentFrame, animated: true)
    }
    
    // MARK: - Private
    @IBOutlet weak private var textInput: DesignableTextInput!
    @IBOutlet weak private var firstNameTextInput: DesignableTextInput!
    @IBOutlet weak private var lastNameTextInput: DesignableTextInput!
    
    @IBOutlet weak private var pickerView: DesignablePicker!
    @IBOutlet weak private var datePickerView: DesignableDatePicker!
    @IBOutlet weak private var genderPicker: DesignablePicker!
    
    @IBOutlet weak private var cardNumberTextInput: DesignableMaskedTextInput!
    @IBOutlet weak private var cardValidTillDatePicker: DesignableMonthYearPicker!
    @IBOutlet weak private var cardCVVTextInput: DesignableMaskedTextInput!
    
    @IBOutlet private var buttons: [UIButton]!
    @IBOutlet private var containers: [UIView]!
    @IBOutlet private var labels: [UILabel]!
    
    let pickerDataSource = "Orange, Green, Blue, Red".components(separatedBy: ",").map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
    let genderDataSource: [Gender] = [.female, .male]
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
//        print("[\(type(of: self)) \(#function)]")
    }
    
    func textInputDidEndEditing(_ textInput: DesignableTextInput)
    {
//        print("[\(type(of: self)) \(#function)]")
    }
}

// MARK: - PickerInputDelegate
extension HomeViewController: PickerInputDelegate
{
    func pickerInput(_ picker: DesignablePicker, doneWithValue value: String, andIndex index: Int)
    {
        if let nextInput = picker.nextInput {
            nextInput.becomeFirstResponderForInputView()
        }
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
    
    @nonobjc func pickerInputDidCancel(_ picker: DesignablePicker)
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

// MARK: - MaskedTextInputDelegate
extension HomeViewController: MaskedTextInputDelegate
{
    func textInput(_ textInput: DesignableMaskedTextInput, didFillMandatoryCharacters complete: Bool, didExtractValue value: String)
    {
//        print("[\(type(of: self)) \(#function)] value: \(value)")
        
        // Credit card number
        if textInput == cardNumberTextInput {
            if value.isEmpty {
                textInput.normalImage = nil
                textInput.activeImage = nil
            }
            if textInput.value?.length == 1 || complete {
                if textInput.validate() {
                    if textInput.state == .error {
                        textInput.state = .active
                    }
                    textInput.normalImage = CreditCardType(withNumber: textInput.value)?.icon
                    textInput.activeImage = textInput.normalImage
                } else {
                    textInput.state = .error
                }
                return
            }
            return
        }
    }
}

// MARK: - MonthYearPickerInputDelegate
extension HomeViewController: MonthYearPickerInputDelegate
{
    func pickerInput(_ picker: DesignableMonthYearPicker, doneWithMonth month: Int, andYear year: Int)
    {
        print("[\(type(of: self)) \(#function)] month: \(month) year: \(year)")
    }
}

// MARK: - InputViewValidator
extension HomeViewController: InputViewValidator
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
        
        // Credit card number
        if inputView == self.cardNumberTextInput {
            guard let value = perhapsValue else { return false }
            if value.length == 1 {
                guard let _ = CreditCardType(withNumber: value) else {
                    inputView.errorMessage = "Invalid card vendor!"
                    return false
                }
                return true
            }
            guard value.evaluate(with: "^[0-9]{15,16}$") else {
                inputView.errorMessage = "Invalid credit card number!"
                return false
            }
            guard value.isValidCardNumber() else {
                inputView.errorMessage = "Invalid credit card number!"
                return false
            }
            
            return true
        }
        
        if inputView == self.cardCVVTextInput {
            guard let value = perhapsValue else { return false }
            guard value.evaluate(with: "^[0-9]{3,4}$") else {
                inputView.errorMessage = "Invalid security code!"
                return false
            }
            
            return true
        }
        
        return true
    }
}

// MARK: - Private
extension HomeViewController
{
    private func setupViewsOnLoad()
    {
//        self.title = "Home"
        self.view.backgroundColor = .background
        
        // buttons
        self.buttons.forEach {
            $0.backgroundColor = UIColor.Button.background
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
            $0.titleLabel?.font = UIFont.brand(font: .regular, withSize: .h5)
            $0.setTitleColor(UIColor.Button.title, for: .normal)
        }
        
        // containers
        self.containers.forEach {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
        }
        
        // labels
        do {
            self.labels.forEach {
                $0.textColor = .brand
            }
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
        
        // cardNumberTextInput
        do {
            DesignableMaskedTextInput.setupAppearance(forTextInput: self.cardNumberTextInput)
            self.cardNumberTextInput.normalImageColor = nil
            self.cardNumberTextInput.activeImageColor = nil
            self.cardNumberTextInput.keyboardType = .numberPad
            self.cardNumberTextInput.name = "cardNumberTextInput"
            self.cardNumberTextInput.title = "Card number"
            self.cardNumberTextInput.format = "[0000] [0000] [0000] [0000]"
            self.cardNumberTextInput.maskedDelegate = self
            self.cardNumberTextInput.validator = self
            self.cardNumberTextInput.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please enter a credit card number!")
            ]
        }
        
        // cardValidTillDatePicker
        do {
            DesignableMonthYearPicker.setupAppearance(forPicker: self.cardValidTillDatePicker)
            self.cardValidTillDatePicker.delegate = self
            self.cardValidTillDatePicker.validator = self
            self.cardValidTillDatePicker.name = "cardValidTillDatePicker"
            self.cardValidTillDatePicker.title = "Valid until"
            self.cardValidTillDatePicker.normalImage = UIImage(named: "calendar")
            self.cardValidTillDatePicker.activeImage = UIImage(named: "calendar")
            self.cardValidTillDatePicker.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please select month and year!")
            ]
            self.cardValidTillDatePicker.isSeparatorHidden = true
        }
        
        // cardCVVTextInput
        do {
            DesignableMaskedTextInput.setupAppearance(forTextInput: self.cardCVVTextInput)
            self.cardCVVTextInput.keyboardType = .numberPad
            self.cardCVVTextInput.title = "CVV"
            self.cardCVVTextInput.maskedDelegate = self
            self.cardCVVTextInput.validator = self
            self.cardCVVTextInput.format = "[0000]"
            self.cardCVVTextInput.normalImageColor = .brand
            self.cardCVVTextInput.activeImageColor = .brand
            self.cardCVVTextInput.infoImageColor = .brand
            self.cardCVVTextInput.normalImage = infoInactiveImage
            self.cardCVVTextInput.activeImage = infoInactiveImage
            self.cardCVVTextInput.infoImage = infoActiveImage
            self.cardCVVTextInput.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please enter CVV!")
            ]
            self.cardCVVTextInput.rightButton.isEnabled = true
            self.cardCVVTextInput.rightButton.addTarget(self, action: #selector(self.cardCVVButtonAction(sender:)), for: .touchUpInside)
            self.cardCVVTextInput.infoMessage = "The security code on a credit card is the brief number that is printed on the card that helps verify its legitimacy."
            self.cardCVVTextInput.isSeparatorHidden = true
        }
    }
}
