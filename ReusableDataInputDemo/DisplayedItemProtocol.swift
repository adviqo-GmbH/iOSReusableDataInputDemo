//
//  DisplayedItemProtocol.swift
//  ReusableDataInputDemo
//
//  Created by Oleksandr Pronin on 21.01.19.
//  Copyright © 2019 adviqo. All rights reserved.
//

import UIKit

public protocol DisplayedItemProtocol
{
    var type: DisplayedItemType { get }
    var isSeparatorHidden: Bool { get set }
    var title: String? { get set }
    var icon: UIImage? { get set }
}
