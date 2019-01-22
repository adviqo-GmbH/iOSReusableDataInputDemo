//
//  DisplayedSectionProtocol.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 21.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import Foundation

public protocol DisplayedSectionProtocol
{
    var title: String? { get set }
    var items: [DisplayedItemProtocol] { get set }
}