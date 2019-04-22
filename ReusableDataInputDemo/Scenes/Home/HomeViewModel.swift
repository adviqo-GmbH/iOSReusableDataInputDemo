//
//  HomeViewModel.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 21.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import Foundation
import RxSwift

public enum Gender: Int
{
    case undefined = 0
    case male = 1
    case female = 2
    
    var title: String {
        switch self {
        case .female: return "Female"
        case .male: return "Male"
        case .undefined: return "Not specified"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .female: return UIImage(named: "ic_male")
        case .male: return UIImage(named: "ic_female")
        case .undefined: return UIImage(named: "ic_gender")
        }
    }
}

public enum CreditCardType: String
{
    case visa = "4"
    case masterCard = "5"
    case amex = "3"
    
    public init?(withNumber perhupsNumber: String?)
    {
        guard let number = perhupsNumber else {
            return nil
        }
        guard !number.isEmpty else {
            return nil
        }
        guard let value = CreditCardType(rawValue: String(number.prefix(1))) else {
            return nil
        }
        self = value
    }
    
    public var icon: UIImage? {
        switch self {
        case .visa: return UIImage(named: "Visa")
        case .masterCard: return UIImage(named: "Mastercard")
        case .amex: return UIImage(named: "Amex")
        }
    }
}

struct HomeDisplayedModel
{
    struct Section: DisplayedSectionProtocol
    {
        var title: String?
        var items: [DisplayedItemProtocol]
        
        public init(items: [DisplayedItemProtocol], title: String? = nil)
        {
            self.items = items
            self.title = title
        }
    }
}
