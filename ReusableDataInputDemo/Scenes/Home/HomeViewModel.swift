//
//  HomeViewModel.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 21.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import Foundation
import RxSwift

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
