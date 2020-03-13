//
//  CountryPickerDemoViewController.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 06.12.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit
import ReusableDataInput
import iOSReusableExtensions

class CountryPickerDemoViewController: BaseViewController {
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsOnLoad()
    }
    
    // MARK: - Actions
    @IBAction func validateAction(_ sender: Any) {
        inputViewCollection.forEach { $0.resignFirstResponderForInputView() }
        inputViewCollection.forEach { $0.state = $0.validate() ? .normal : .error }
    }
    @IBAction func clearAction(_ sender: Any) {
        countryPicker.value = nil
        phoneNumberInput.value = nil
    }
    @IBAction func setValueAction(_ sender: Any) {
        countryPicker.value = "DE"
        phoneNumberInput.value = "DE"
    }
    // MARK: - Private
    @IBOutlet weak private var countryPicker: DesignableCountryPicker!
    @IBOutlet weak private var phoneNumberInput: DesignablePhoneNumberInput!
    
    @IBOutlet private var buttons: [UIButton]!
    @IBOutlet private var containers: [UIView]!
    @IBOutlet private var labels: [UILabel]!
}

// MARK: - InputViewValidator
extension CountryPickerDemoViewController: InputViewValidator {
    func inputView(_ inputView: InputView, shouldValidateValue perhapsValue: String?) -> Bool {
        guard let validationRules = inputView.validationRules else { return true }
        for validationRule in validationRules {
            if validationRule.rule.validationHandler(perhapsValue) { continue }
            validationRule.message.map { inputView.errorMessage = $0 }
            inputView.state = .error
            return false
        }
        return true
    }
}

// MARK: - PickerInputDelegate
extension CountryPickerDemoViewController: PickerInputDelegate {
    func pickerInput(_ picker: DesignablePicker, doneWithValue value: String, andIndex index: Int) {
        if picker == countryPicker {
            phoneNumberInput.countryCode = value
            return
        }
    }
    func pickerInputDidCancel(_ picker: DesignablePicker) {
    }
}

// MARK: - PhoneNumberInputDelegate
extension CountryPickerDemoViewController: PhoneNumberInputDelegate {
    func textInput(_ textInput: DesignableMaskedTextInput, didChangeCountryWithISOCode isoCode: String?) {
        if let isoCode = isoCode {
            print("[\(type(of: self)) \(#function)] isoCode: \(isoCode)")
        }
        countryPicker.value = isoCode
    }
}

// MARK: - Private
extension CountryPickerDemoViewController {
    private func setupViewsOnLoad() {
//        self.title = "Country & phone"
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
        
        let countries = ["UA", "DE", "AT", "CH", "NL", "BE", "FR", "DK", "PL", "CZ", "UK", "BG", "CY", "EE", "ES", "FI", "GR", "HU", "IE", "IT", "LI", "LT", "LU", "LV", "MC", "MT", "PT", "RO", "SE", "SI", "SK"]
        
        // countryPicker
        do {
            DesignableCountryPicker.setupAppearance(forPicker: self.countryPicker)
            self.countryPicker.data = countries
            self.countryPicker.delegate = self
            self.countryPicker.validator = self
            self.countryPicker.name = "countryPicker"
            self.countryPicker.title = "Country"
            self.countryPicker.value = "DE"
        }
        
        // phoneNumberInput
        do {
            DesignablePhoneNumberInput.setupAppearance(forPhoneNumberInput: phoneNumberInput)
            phoneNumberInput.data = countries
            phoneNumberInput.keyboardType = .numberPad
            phoneNumberInput.title = "Phone number"
            phoneNumberInput.maskedDelegate = self
            phoneNumberInput.validator = self
            phoneNumberInput.countryCode = "DE"
            phoneNumberInput.validationRules = [
                ValidationRule(rule: .emptyString, message: "Please enter phone number!")
            ]
        }
    }
}
